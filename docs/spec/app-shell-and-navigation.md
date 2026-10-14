# BOOST addendum 4: App shell, navigation and the seven tabs

Answers: how BOOST is laid out (Gaya on the left, search bar, tabs on top, settings top right), what each of the seven tabs holds, and what changes in the canon.

Last updated: 14 Oct 2026

Sources: Fred's request of 14 Oct 2026 ("analyse the whole UI and UX and replicate it for BOOST: chat on the left bar, search bar, tabs on top, settings on the top right; tabs Dashboard, Browse jobs, Boost apply, Job tracker, Outreach, Profile, Research"); Tsenta's dashboard, seen read only in Fred's own account on 14 Oct 2026 (Dashboard, Browse jobs, Auto Apply, Tracker, Networking, Profile, Research, Settings); 06 Blueprint; Design Brief sections 4 to 8; App Flow section 3; addendum 3 (docs/spec/networking-and-gaya.md).

Prototype: docs/prototypes/boost-app.html (fictional data; every tab, the search, Gaya, Settings and the drawers work). It shows layout and behaviour only; the Design Brief tokens, components and copy rules still govern the build.

How to read it: this file amends the canon and supersedes the navigation parts of the Design Brief (AppShell, BottomTabBar, sidebar) and App Flow section 3. CLAUDE.md wins on rules. Build in our own words and design; never copy Tsenta's screens, text or imagery (06 Risks).

## 1. What Tsenta's interface does (14 Oct 2026, read only)

| Area | Tsenta | BOOST verdict |
| :- | :- | :- |
| Shell | Logo, a panel toggle that opens a chat on the left, 7 text tabs on top, Settings and a credits pill top right | **Take** the layout. The credits pill becomes a mode and daily limit pill ("Review · 3 of 5 today"); no wallet (L3, L6) |
| Dashboard | Job search bar with "Title + description", Exclude, 11 filter chips; "Top job matches" cards with Pass and Apply; "Apply to all"; an "All applications" table with status tabs (All, Submitted, In flight, Needs you, Failed, Skipped) and "Approve all" | **Change**: Dashboard is BOOST's Today: your call, going out at 12:00 with Hold, Needs you, follow ups, week numbers with reasons, step progress, top matches. No "Apply to all" |
| Browse jobs | Same search and filters, Saved, "Jobs look off? Ask the feed assistant", "Add your own link", cards with match %, skill chips, Save, Details, Pass, Apply | **Take** with BOOST rules: verified live only (L47), score with 2 written reasons and gaps (F8, L46), target tier first, "Tune with Gaya", "Add a job" (job-add), "Prepare my application" instead of Apply |
| Auto Apply | Upsell header; a chat that previews what it would apply to; lanes (1 of 5); shared daily cap; manual settings | **Change**: "Boost apply" is the Applications screen plus mode, daily limit step and lanes summary. The preview chat is Gaya (left panel). No upsell |
| Tracker | Inbox (a private email address that catches ATS mail, category chips, Compose) and Pipeline (stage chart, board, Import CSV, Export CSV, Add application) | **Change**: "Job tracker" with Pipeline (7 BOOST stages, "Move to", Export my tracker, Add an application) and Employer emails (forwarded by the client, F33; no private ATS inbox, G4, G5; no Compose: BOOST never sends) |
| Networking | Company lookup, contacts, notes, news | **Change**: "Outreach", as addendum 3 |
| Profile | Several CV profiles, Resume, Cover Letter, Profile Details, completeness %, application defaults including voluntary self ID | **Change**: Profile holds My Story (Fact Bank), CV (check and variations), Target companies, Preferences and Application answers. Sensitive answers masked; self ID "Prefer not to say" by default (G3) |
| Research | Editorial articles with tags and read times | **Take**: TalentFB articles, claim safe, each ending with one action in BOOST |
| Settings | Apply settings (CV optimisation Off, Honest, Aggressive; auto approve; review before submit), memory, public portfolio, Workday password, Job Boards, Plans and billing, Referrals, Email integrations, AI assistants, Account | **Change**: Apply settings (mode, Honest only, review before submit, daily limit), Lanes, What Gaya knows, Location and exclusions, Notifications, Email forwarding, Plan and access, Data and privacy, Account. **Reject**: Aggressive mode, Workday password, Job Boards, referral credits, prepaid plans. **Later**: public portfolio, AI assistants (MCP), mailbox connection |

## 2. The shell

**Desktop (lg, 1024 px and up)**

- **Top bar, 64 px, White, 1 px Line below.** Left to right: Gaya toggle (PanelLeft icon, 44 px, pressed state Violet tint), wordmark, the seven tabs, then on the right the status pill, "Settings" (gear and label), the avatar menu.
- **Tabs:** text tabs, Inter SemiBold 15, 40 px high, radius 12; active tab Violet tint fill with Deep Violet text; hover Mist. Boost apply carries a count badge (packs waiting for the client's call). Order fixed: Dashboard, Browse jobs, Boost apply, Job tracker, Outreach, Profile, Research.
- **Status pill:** Midnight, white text: "Review · 3 of 5 today" (mode, daily limit used). Hybrid and Auto show their own label. No credits, no countdown.
- **Settings** opens /settings (section 6). **Avatar menu:** name, plan and access end date (a date, never a countdown), My profile, Export or delete my data, Contact your coach, Sign out.
- **Search row, under the top bar, on every screen:** scope select (Everything, Jobs, Companies, Applications) and the search field "Search jobs, companies and your applications", Ctrl K or Cmd K to focus. Results grouped: Jobs (opens the job drawer), Companies (opens the company page in Outreach), Your applications (opens the receipt drawer). No result: "Look up \[name\]", which spends one company lookup (addendum 3).
- **Gaya panel on the left** (addendum 3, section 5): 380 px, between the window edge and the page, open by default on first visit from lg, state remembered per device. The context chip follows the tab ("Looking at: Browse jobs") or the open company.
- **Page area:** max 1200 px, 28 px gutters. Detail views open in a right drawer (560 px, radius 20 on the left, scrim Midnight 48%) so the list stays in place: job details, application receipt, add an application.

**Phone (below lg)**

- Top bar 56 px: Gaya toggle, mark, then gear and avatar on the right. The status pill moves into Settings and the Dashboard header.
- Tabs: a horizontal pill strip under the top bar, scrollable, the active tab Midnight with white text and scrolled into view. This replaces the five tab bottom bar \[Rec\]: seven tabs do not fit a bottom bar at 44 px targets.
- Search row stays, without the scope select.
- Gaya opens full screen; drawers open full width.

**Before step 3 unlocks** \[Rec\]: tabs shown are Dashboard (setup checklist and step progress), Profile (the My Story import) and Research. The other four stay hidden, not disabled (Design Brief AppShell rule), and appear together when step 3 unlocks.

## 3. The seven tabs

| Tab | Route | Replaces in the canon | What it holds | Phase |
| :- | :- | :- | :- | :- |
| Dashboard | /dashboard | /today | Date and greeting, mode and daily limit chips, five step progress, 4 week numbers each with a reason line, Your call (PackCards: Approve, See my application, Skip), Needs you inline, Going out at 12:00 with Hold, Follow ups due today, Top matches today | 2 (setup view in 1) |
| Browse jobs | /jobs, /jobs/saved | /jobs | "Hide jobs mentioning" field, filter chips (Level, Location setting, Workplace, Target tier, Lane, Minimum match, Posted, Work rights), "Tune with Gaya", "Add a job" card, JobCards (score ring, band, tier, Verified live, 2 reasons), Save, Details drawer (reasons, gaps, highlighted post, next 5 steps), "Prepare my application" | 2 |
| Boost apply | /apply, /apply?tab= | /applications | Mode switch (Hybrid and Auto locked with the reason), cards for Mode, Daily limit step, Lanes summary; status tabs Ready for you, Going out today, Submitted, Handed back, Skipped; table rows open the receipt drawer; "Approve all that passed every check" (never Tier 1 or Needs you) | 2, mode and lanes in 3 |
| Job tracker | /tracker, /tracker/emails | /pipeline | Pipeline: 4 numbers, the 7 stage board (Applied, Approached, Replied, Interviewing, Offer, Not this time, No reply), "Move to", "Export my tracker", "Add an application". Employer emails: forwarding address with Copy, category chips, list and reader, "Move to Interviewing" or "Log a reply", "Draft my reply with Gaya" | 2, emails in 4 |
| Outreach | /outreach, /outreach/company/\[id\] | /outreach | As addendum 3 | 4 |
| Profile | /profile, /profile/\[section\] | /my-story/\*, /targets, /my-story/preferences | Header card (CV score, facts approved, "Update my story"); sub tabs My Story (Fact Bank, positioning), CV (score, top 3 fixes, variations), Target companies (tiers, watch switch), Preferences, Application answers (sensitive masked) | 1 |
| Research | /research, /research/\[slug\] | none (06 cut list item 1) | Article list with tag filter, read time, number; reader in the 720 px column ending with "Try it in BOOST" and a link | 2 \[Rec\] |
| Settings | /settings/\[section\] | /settings, /settings/mode, /settings/lanes | Left section nav (top strip on phone): Apply settings, Lanes, What Gaya knows, Location and exclusions, Notifications, Email forwarding, Plan and access, Data and privacy, Account | 1, grows each phase |

Route redirects: /today to /dashboard, /applications to /apply, /pipeline to /tracker, /my-story to /profile, /targets to /profile/targets, so links in emails already specified (digest, sent today) keep working \[Rec\].

## 4. Research content

- Articles are Markdown files in content/research/ with front matter (slug, title, tag, minutes, summary, cta_label, cta_href, published_on). No database table, no editor in v1 \[Rec\]; a new article is a pull request.
- Fred writes or approves every article (Reverse Job Search newsletter editions adapted). Copy rules apply: no dashes, banned words or outcome claims; credentials only from the locked stack.
- The prototype titles are placeholders, not content.

## 5. Global search

- Server action under the user's session and RLS: jobs only from the client's own matches (verified live), companies from the shared table, applications and packs from the client's rows. Postgres full text on title and company name \[Rec\]; 8 results per group; debounce 200 ms.
- Recent searches kept per device (localStorage, try and catch).
- Nothing leaves BOOST, except "Look up \[name\]", which is company-lookup (addendum 3).

## 6. Settings sections

| Section | Contents | Phase |
| :- | :- | :- |
| Apply settings | Mode switch (Review, Hybrid, Auto with lock reasons, Back to Review in one tap), CV tailoring "Honest" (fixed, explained), review before submit (on in Review), daily limit and next step, cover letters | 1 (view), 3 (mode) |
| Lanes | Lane cards, LaneEditor (addendum 2 L48) | 3 |
| What Gaya knows | Preferences confirmed in chats, each removable (facts table, preference type) | 2 |
| Location and exclusions | Local, regional, global; confidentiality exclusions (sensitive) | 1 |
| Notifications | Digest 07:30, Sent today 13:00, weekly report; WhatsApp shown as "Coming later" | 2 |
| Email forwarding | Forwarding address with Copy; mailbox connection "Coming later" | 4 |
| Plan and access | Plan, access dates, "Contact your coach" (payments stay in GoHighLevel) | 1 |
| Data and privacy | Export my data, Request deletion (ConfirmDialog asking for the email), DPO line | 1 |
| Account | Email and sign in methods, time zone | 1 |

## 7. Changes to the canon

- **Design Brief:** AppShell becomes TopBar (Gaya toggle, wordmark, TopTabs, StatusPill, SettingsLink, AccountMenu), SearchRow, GayaPanel, and the phone TabStrip. BottomTabBar and the Midnight sidebar are retired; Midnight stays for the status pill, the active phone tab and chips. Section 8 routes renamed as section 3 above. New components: TopTabs, TabStrip, StatusPill, GlobalSearch, DetailDrawer, StatCard, FilterChip, ArticleCard, SettingsNav. Microcopy from section 8 below.
- **App Flow:** section 3 navigation and the route table replaced by section 3 above; journeys keep their steps with renamed routes.
- **PRD:** add F57 Global search and F58 Research; Research leaves the cut list unless Fred puts it back (D49).
- **TRD:** section 8 folders: app/(client)/dashboard, jobs, apply, tracker, outreach, profile, research, settings; content/research/.
- **Implementation plan:** section 9 of this file.

## 8. Microcopy

| Moment | Label or message |
| :- | :- |
| Tabs | "Dashboard" / "Browse jobs" / "Boost apply" / "Job tracker" / "Outreach" / "Profile" / "Research" / "Settings" |
| Status pill | "Review · 3 of 5 today" / "Hybrid · 6 of 10 today" / "Auto · 4 of 10 today" |
| Search | "Search jobs, companies and your applications" / groups "Jobs", "Companies", "Your applications" / "Look up \[name\]" |
| Dashboard | "Good afternoon, Alex" / "Your call today" / "Going out at 12:00" / "Follow ups due today" / "Top matches today" |
| Browse jobs | "Hide jobs mentioning" / "Jobs look off? Tune with Gaya" / "Add a job" / "Prepare my application" / "Only roles verified live by 3 or more sources." |
| Boost apply | "Approve all that passed every check" / "Tier 1 targets and Needs you questions are never approved in bulk." / "Hybrid unlocks at 10 clean applications: 7 of 10." |
| Job tracker | "Export my tracker" / "Add an application" / "Employer emails" / "Your forwarding address" / "You reply from your own email. BOOST never sends." |
| Research | "Try it in BOOST" / "4 min read" |
| Settings | "CV tailoring: Honest. BOOST reorders and rephrases your approved facts. It never adds a claim you have not approved." |

## 9. Build steps (insert into the implementation plan)

Start each prompt with: "Read CLAUDE.md, docs/spec/app-shell-and-navigation.md, docs/spec/networking-and-gaya.md and the docs this step names. Open docs/prototypes/boost-app.html for layout only."

- **1.3 changes: App shell v2** (replaces "the phone first app shell with the five tabs")
  - Build: TopBar, TopTabs, TabStrip, StatusPill, SettingsLink, AccountMenu, SearchRow (search disabled until 2.28), an empty GayaPanel slot, the eight routes with empty states and the redirects; tabs hidden before step 3 as section 2.
  - Done when: Playwright at 375 and 1440 px: every tab reachable, no sideways scroll, focus visible, the dummy client before step 3 sees Dashboard, Profile and Research only.
  - Fred checks: signs in as both dummy clients on phone and laptop.
- **1.x renames:** the My Story, Targets and preferences steps build under /profile; mode, lanes and location under /settings. No change to their scope.
- **2.28 Global search** (Phase 2, after the job feed exists)
  - Build: GlobalSearch server action, grouped results, keyboard shortcuts, recent searches.
  - Done when: test:rls style test: client A never sees client B's applications or matches in results.
- **2.29 Research** (Phase 2 \[Rec\]; or later if D49 keeps it cut)
  - Build: content/research/ loader, list with tag filter, reader, the "Try it in BOOST" block; 3 seed articles from Fred.
  - Done when: copy test passes on every article.
- Dashboard, Browse jobs, Boost apply and Job tracker keep their existing Phase 2 steps with the new routes and layouts.

Hours \[Est\]: shell v2 about the same as the old shell step; global search about 2 hours; Research about 3 hours plus Fred's writing. Total about 5 more of Fred's hours, on top of addendum 3's 10.

## 10. Decisions

| ID | Question | \[Rec\] | Waits on it |
| :- | :- | :- | :- |
| D44 | Tab label for outreach | Settled by Fred on 14 Oct 2026: "Outreach" | none |
| D48 | Phone navigation: scrollable tab strip under the top bar, or a 5 tab bottom bar with "More" | Tab strip, so the seven tabs match the laptop | 1.3 |
| D49 | Research back in scope (06 cut list item 1)? | Yes, as Markdown articles, Phase 2 | 2.29 |
| D50 | Gaya panel open by default on laptop? | Yes on first visit, then remembered per device | 2.27 |
| D51 | Which tabs show before step 3 | Dashboard, Profile, Research | 1.3 |
