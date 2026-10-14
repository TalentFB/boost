-- BOOST addendum 3: Networking and the Gaya chat
-- Reference SQL, not a migration. Claude Code splits it into migrations under
-- supabase/migrations/ (TRD section 9), each table with its RLS in the same migration.
-- Needs Part 1 of docs/backend-schema.sql (my_client_id(), is_coach(), set_updated_at).
-- Never run against boost-prod by hand.

-- ============================================================
-- Migration A (step 2.26): Gaya chat
-- ============================================================

create table gaya_threads (
  id uuid primary key default gen_random_uuid(),
  client_id uuid not null references clients(id) on delete cascade,
  title text not null default 'New chat',
  context_json jsonb not null default '{}',
  archived boolean not null default false,
  created_at timestamptz not null default now(),
  last_message_at timestamptz not null default now()
);
create index gaya_threads_client_recent on gaya_threads (client_id, last_message_at desc);

create table gaya_messages (
  id uuid primary key default gen_random_uuid(),
  thread_id uuid not null references gaya_threads(id) on delete cascade,
  client_id uuid not null references clients(id) on delete cascade,
  role text not null check (role in ('client', 'gaya')),
  content text not null,
  drafts_json jsonb not null default '[]',   -- [{slot, kind, text, char_count, fact_ids}]
  fact_ids uuid[] not null default '{}',     -- approved facts behind Gaya's claims (G3)
  model text,
  prompt_version text,
  input_tokens int,
  output_tokens int,
  created_at timestamptz not null default now()
);
create index gaya_messages_thread on gaya_messages (thread_id, created_at);
create index gaya_messages_client_day on gaya_messages (client_id, created_at) where role = 'client';

-- A message's client_id must match its thread's client_id.
create or replace function gaya_messages_same_client() returns trigger
language plpgsql as $$
begin
  if new.client_id <> (select client_id from gaya_threads where id = new.thread_id) then
    raise exception 'gaya_messages.client_id does not match its thread';
  end if;
  return new;
end $$;
create trigger gaya_messages_same_client before insert or update on gaya_messages
  for each row execute function gaya_messages_same_client();

alter table gaya_threads enable row level security;
alter table gaya_messages enable row level security;

-- Clients: read own threads, start a thread, rename or archive it. No delete (deletion runs through client-deletion).
create policy gaya_threads_client_select on gaya_threads for select
  using (client_id = my_client_id());
create policy gaya_threads_client_insert on gaya_threads for insert
  with check (client_id = my_client_id());
create policy gaya_threads_client_update on gaya_threads for update
  using (client_id = my_client_id()) with check (client_id = my_client_id());
revoke update on gaya_threads from authenticated;
grant update (title, archived) on gaya_threads to authenticated;

-- Clients read their own messages; only gaya-chat (secret key) inserts.
create policy gaya_messages_client_select on gaya_messages for select
  using (client_id = my_client_id());
revoke insert, update, delete on gaya_messages from authenticated;

-- Coach read access depends on D45. [Rec] yes: uncomment once Fred decides.
-- create policy gaya_threads_coach_select on gaya_threads for select using (is_coach());
-- create policy gaya_messages_coach_select on gaya_messages for select using (is_coach());

-- Daily cap helper: client messages today in the client's time zone.
create or replace function gaya_messages_today(p_client uuid, p_tz text) returns int
language sql stable security definer set search_path = public as $$
  select count(*)::int from gaya_messages
  where client_id = p_client and role = 'client'
    and (created_at at time zone p_tz)::date = (now() at time zone p_tz)::date;
$$;
revoke execute on function gaya_messages_today(uuid, text) from public, authenticated;

-- ============================================================
-- Migration B (step 4.9a): company lookups, company card columns, news
-- ============================================================

alter table companies
  add column summary_line text,
  add column size_band text,
  add column hq_city text,
  add column industries text[] not null default '{}',
  add column website_url text,
  add column company_page_url text;   -- stored as text only, never read (G1)

alter table company_research
  add column news_json jsonb not null default '[]';
  -- [{publisher, published_on, title, url, summary_in_our_words}]

create table company_lookups (
  id uuid primary key default gen_random_uuid(),
  client_id uuid not null references clients(id) on delete cascade,
  company_id uuid references companies(id) on delete set null,
  query text not null,
  local_date date not null,             -- the client's local date, for the 10 a day cap
  looked_up_at timestamptz not null default now()
);
create index company_lookups_client_day on company_lookups (client_id, local_date);

alter table company_lookups enable row level security;
create policy company_lookups_client_select on company_lookups for select
  using (client_id = my_client_id());
create policy company_lookups_coach_select on company_lookups for select
  using (is_coach());
revoke insert, update, delete on company_lookups from authenticated;

-- Extend automation_spend.kind with the two new kinds.
-- If the canon defines kind with a check constraint, replace it; adjust the name to the one in Part 2.
do $$
declare c text;
begin
  select conname into c from pg_constraint
  where conrelid = 'automation_spend'::regclass and contype = 'c'
    and pg_get_constraintdef(oid) ilike '%kind%';
  if c is not null then
    execute format('alter table automation_spend drop constraint %I', c);
  end if;
end $$;
alter table automation_spend add constraint automation_spend_kind_check check (kind in (
  'extraction', 'cv_check', 'scoring', 'pack_writing', 'verifying', 'outreach_writing',
  'deck', 'submission', 'inbox_parse', 'report',
  'company_lookup', 'gaya_chat'
));

-- ============================================================
-- Migration C (step 5.9, only if D46 is yes): Your network
-- ============================================================

-- create table network_connections (
--   id uuid primary key default gen_random_uuid(),
--   client_id uuid not null references clients(id) on delete cascade,
--   first_name text not null,
--   last_name text not null,
--   company_name text,
--   company_id uuid references companies(id) on delete set null,
--   position text,
--   profile_url text,                 -- text only (G1); the parser drops the export's email column (G13)
--   imported_at timestamptz not null default now()
-- );
-- create index network_connections_client_company on network_connections (client_id, company_id);
-- alter table network_connections enable row level security;
-- create policy network_connections_client on network_connections for select using (client_id = my_client_id());
-- create policy network_connections_client_delete on network_connections for delete using (client_id = my_client_id());
-- create policy network_connections_coach on network_connections for select using (is_coach());
-- revoke insert, update on network_connections from authenticated;

-- ============================================================
-- Deletion: client-deletion must also remove gaya_threads, gaya_messages,
-- company_lookups and network_connections (all cascade from clients).
-- ============================================================
