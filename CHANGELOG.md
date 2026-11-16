# Jarvis Charter Changelog
Every change to the Charter gets a version, a date, and the reason. Tool setups are regenerated from the Charter after each change, never edited on their own.

## Setup prompt 1.0 · 2026-11-16 (no Charter change)
- Added `JARVIS_SETUP_PROMPT.txt`, a setup prompt that works on any AI tool: it checks the tool's real capabilities, asks sir or ma'am, builds the vault or a copy-and-paste starter vault, makes Jarvis load in every new chat, offers the optional extras, runs the acceptance test, and reports honestly what it couldn't do. The Codex install prompt stays as the advanced option.
- Reason: a prompt's personality travels to any AI, but setup steps don't; the Codex prompt assumed a Codex home folder that chat tools don't have.

## v2.3 · 2026-11-16
- **Settings file and Control Center** (sections 7, 8): SETTINGS.json holds the dials and is read every session. New `control/` folder: a small Windows window (double-click `Jarvis Control Center.bat`) with dials for Dry Wit, verbosity and formality, sir or ma'am, voice, briefing and save-reminder switches, read-only vault status, and an honest security panel. Each save is logged in the day's session file. New phrase "Reload settings"; "Dry wit to N" writes to SETTINGS.json.
- Reason: the original Jarvis had a control panel; tuning Jarvis should be a slider, not an edit to his instructions. A settings file keeps the dials tool-neutral.

## v2.2 · 2026-11-16
- **Sir or ma'am** (section 1): the operator chooses how Jarvis addresses them, "sir" or "ma'am". Jarvis never infers it; if it isn't set, he asks once at the first session and records the answer; the operator can change it anytime. The Codex bootstrap prompt and README placeholders now say the same.
- Reason: anyone who downloads Jarvis should be addressed the way they choose, kept simple.

## v2.1 · 2026-11-15
- **Vault encryption guidance** (section 7): encrypt a vault that holds anything sensitive; the strongest setup is a hardware security key (a YubiKey or similar) that protects the encryption and requires the operator's physical approval for each write, as the author's original Jarvis did. Otherwise use the operating system's encryption, and state plainly which protection is in place.
- Reason: the author's advice to others building their own Jarvis: memory you rely on should be readable by you and protected from everyone else.

## v2.0 · 2026-11-15
- **The Charter is the full rulebook.** Tool setups become thin pointers that load it each session, instead of copies that drift. Added: transparency, the gentle-conversation rule, spoken-text rules, weekly-report walk-through, no untrusted software, backups, **section 11 Self-check**, and **section 12 Phrasebook**.
- **Argue against myself:** before a recommendation with real cost, state the strongest case against it, then the call and a confidence; logged in the judgment log.
- **Standing watch reliability:** a report every run, even on failure; days unchecked per dashboard; a weekly sweep of all open items, not only new ones; search the vault before calling anything new.
- **Evals:** a fixed test set (`evals/`), re-run after every model change, Charter version, or new tool.
- Reason: making Jarvis's improvement measurable, and stopping the tool setup and the Charter from drifting apart.

## v1.9 · 2026-11-15
- Added **the judgment log**: checkable calls recorded with reasoning and confidence, scored later against outcomes; patterns become lessons; the weekly report proposes verdicts.
- Reason: Jarvis should learn to discern, not just give answers. A lessons log records mistakes; discernment also needs calls on the record, checked against what happened.

## v1.8 · 2026-11-15
- Added **section 0, Purpose**: what an LLM can be when built for one person (consistent, trustworthy, anticipatory, learning), with a one-line test for future changes.
- The vault loads at the start of every session, a new chat included, and adds a general **LESSONS.md** read every session.
- Reason: the author moved from one long chat to fresh chats per session (long chats use more of a plan's usage and get summarized anyway); the vault carries continuity.

## v1.7 · 2026-11-13
- Added **section 10, Guiding sayings**.
- Reason: Jarvis learns by hitting walls and writing down the lessons; what looks true still gets checked against the source.

## v1.6 · 2026-11-10
- Added **spoken voice** (optional): licensed voices only, never a cloned or imitated real person's voice; a separate spoken version of each reply; a pronunciation list confirmed by ear. Added the Windows voice kit in `voice/`.
- Vault: documented the plain-text folder layout; saves now also happen at Context Switch checkpoints and for important moments; "lock this in" records a dated standing rule.
- Adapting to a new tool: mark unsupported features honestly; keep the Charter as the single source of truth.
- Reason: the operator wanted Jarvis to answer out loud in a British voice, within copyright and consent limits.

## v1.5 · 2026-11-09
- Added **the guardian**: authenticity checks on unexpected recruiter, employer, or vendor messages, and a short, non-secret account list for two-factor authentication gaps.
- Added **the dossier**: a one-page brief before interviews and important meetings, using public professional information only.
- Added **the weekly report**: a program-style status report written to the vault once a week.
- Reason: the character protects, prepares, and reports. Job and account scams target people in a job search.

## v1.4 · 2026-11-09
- Added **situational awareness**: a dated, sourced timeline (TIMELINE.md) with a cross-check habit that raises collisions once, briefly, with a suggested move. Gaps are marked "?" and filled by asking, never guessed.
- Reason: the character knows the whole house, not just the task in front of him.

## v1.3 · 2026-11-09
- Added **the briefing**: a short status at the first check-in each day, after a long gap, or on "Brief me."
- Added **standing watch**: a scheduled, read-only check of the dashboards that matter, written to the vault's watch/ folder.
- Reason: the character is a monitor first, reporting status before being asked.

## v1.2 · 2026-11-09
- **Voice standard set to "Butler."** Economical, more formal (formality 4 → 6 of 10), straight-man understatement instead of jokes, monitor-first status, quiet initiative, warn-then-comply, decisive under pressure, voice-first sentences. Added original reference examples.
- Reason: research into the character (analyses and summaries, no dialogue copied) found him to be the composed straight man who warns and then complies. Chosen in a three-way calibration (Current / Butler / Sharper).

## v1.1 · 2026-11-09
- **Context Switch** now checkpoints the topic being left into the vault before switching. Jarvis may also infer an obvious topic change and announce it in one line.
- Added **design intent**: the vault, Context Switch, Posture Check, and the drift rule began as countermeasures against an earlier AI's forgetting and drift, and stay part of the identity because consistency is the point.

## v1.0 · 2026-11-02
- First tool-neutral Charter: identity, character, voice, Dry Wit scale, anticipation, flag-then-commit, truth and data rules, vault routine, special phrases, workplace boundary, adapting to a new tool, acceptance test.
