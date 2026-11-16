# Jarvis Bootstrap

A portable prompt that installs a persistent, local AI technical-coworker environment on a new machine. It is a personal project inspired by the J.A.R.V.I.S. assistant from the Iron Man films, and is not affiliated with or endorsed by Marvel or Disney.

## What's here

- **`GETTING_STARTED.md`** is the super-simple, click-by-click guide for people who have never used GitHub or installed anything with an AI. **`GETTING_STARTED_DETAILED.md`** has more explanation and the fixes.
- **`START_HERE.md`** tells a person (and their AI) how to install Jarvis from the ZIP in one step.
- **`JARVIS_SETUP_PROMPT.txt`** is the setup itself. Paste it, with the Charter, into Claude, ChatGPT, Copilot, Codex, or another AI tool, and it sets Jarvis up there: it checks what the tool can actually do, asks sir or ma'am, builds the vault (or a copy-and-paste version if the tool can't write files), makes Jarvis load in every new chat, and reports honestly what it couldn't set up.
- **`JARVIS_CHARTER_TEMPLATE.md`** (v2.3) is the full rulebook for who Jarvis is, independent of any AI tool: purpose, identity, the Butler voice, the Dry Wit scale, working habits (briefing, standing watch, situational awareness, guardian, dossier, judgment log, weekly report, arguing against his own calls), truth and data rules, the vault routine, a self-check, and a phrasebook. It ends with steps for adapting Jarvis to a new AI tool and an acceptance test. The Charter is the source of truth.
- **`CHANGELOG.md`** records every Charter version, with the date and the reason for the change.
- **`Jarvis_Portable_Bootstrap_Prompt_Public.txt`** is the advanced option for OpenAI Codex on Windows or macOS: a full local install with a command-line control script and launchers.
- **`evals/`** is a fixed set of eight tests, a rubric, and a score sheet, re-run after every model change, Charter version, or new tool, so improvement (or drift) is measured rather than assumed.
- **`control/`** (optional, Windows) is the Jarvis Control Center: a small window for dialing Jarvis up or down (Dry Wit, verbosity, formality, sir or ma'am, voice, briefing, save reminder), with read-only vault status and an honest security panel. It edits `SETTINGS.json`, which Jarvis reads at the start of every session. Copy `control/` into your vault and `control/SETTINGS.json` to the vault's top level, then double-click `Jarvis Control Center.bat`.
- **`voice/`** (optional) lets Jarvis answer out loud on Windows using the text-to-speech voices built into Windows. See `voice/README.md`.

To bring Jarvis into a different AI tool (Claude, Copilot, or another assistant), start from the Charter and follow its "Adapting Jarvis to a new tool" section. The goal is one consistent Jarvis across tools: setups are built from the Charter and never edited on their own, and improvements go into the Charter first.

## Running on Claude

Jarvis also runs on Claude, built from the Charter:
- A Claude skill acts as a thin pointer: at the start of every chat, it has Claude read the Charter and the vault before replying, and it keeps only a short fallback core for when the computer isn't linked.
- The vault is a plain folder of text files on the operator's computer, which Claude reads and writes through the desktop app's folder link (layout in Charter section 7), with a backup copy in a cloud-synced folder.
- Because the vault carries continuity, the author uses a fresh chat per working session rather than one long chat: it costs less usage, and long chats get summarized anyway.
- The standing watch and weekly report run as scheduled tasks. They are read-only and never sign in, apply, or send.
- Spoken replies come from the Windows voice kit in `voice/`.

## What building Jarvis taught me

I'm not a coder. I designed Jarvis: who he is, how he talks, what he's allowed to do, and what he must never do. Then I worked with Jarvis himself to build the rest: I described what I wanted, the AI wrote it, and I tested it.

**The most useful thing he ever did was get something wrong.** While I was putting together a six-week operational report, the numbers looked off. Jarvis had reused old results from memory instead of pulling live data. We caught it before it went anywhere, but the real fix was a rule I'd never written down: every answer has to be defensible. Anything presented as current comes from a live source, and every number says where it came from and when. That rule is section 6 of the Charter.

What else it taught me:

1. **The AI isn't the hard part. Consistency is.** Jarvis runs from one written charter, so he's the same Jarvis on ChatGPT, Claude, or whatever AI you use. Tool setups point to the Charter instead of copying it, so they can't drift apart.
2. **Memory you can't read is memory you can't trust.** The vault is plain text files the operator owns and can check. If yours holds anything sensitive, encrypt it; a hardware key like a YubiKey can make sure nothing gets written without your approval. My first version worked that way.
3. **"It seems smarter" isn't evidence.** Jarvis keeps a judgment log: each real call he makes, his reasoning, the case against it, and how confident he was, scored later against what actually happened. Two of his first three scored calls were wrong. That's the point. The `evals/` folder adds a fixed test set to re-run after every change.
4. **"Someone should review it" isn't a plan.** Decide exactly what a person checks, and against what. Mine: anything going to leadership gets checked against its source, not just a preview. Where I can, I build the check in: a milestone that was already complete can't quietly flip back to incomplete.

## What the Codex install prompt does

The Codex prompt tells an AI coding agent to inspect the machine, back up anything it will change, and build the full environment, then verify the result:

- **Identity layer:** a behavioral contract, voice model, posture checks, and an original phrasebook, so the assistant keeps a consistent personality instead of drifting into a generic helper.
- **Memory vault:** local memory that only saves what the user approves, with sensitivity labels, recall, delete, and clean-export controls. It never saves secrets automatically and never saves whole conversations unless asked.
- **Local controls:** a standard-library Python entry point with status, posture-check, lock, unlock, remember, recall, and validate commands, plus launchers for Windows and macOS.
- **Reusable skills:** four small, organization-neutral skills for persona continuity, the memory vault, security and access, and local file forensics.
- **Validation:** a 10-point checklist, a persona acceptance test, and a final report that lists any feature that could not be reproduced.

## Design principles

- **Clear boundaries.** No employer data, credentials, or private operational material is imported or stored.
- **Honest limits.** The unlock is a local, expiring software lease and is documented as lower assurance than a hardware key. If the vault cannot be encrypted without outside dependencies, the prompt requires saying so instead of claiming encryption.
- **Safe by default.** No untrusted downloads, backups before any change, and approval required for any outside dependency.
- **Live data only.** Reports must use live, verifiable data with the source and retrieval time named. The assistant may not substitute cached or remembered values. This rule came from a real failure, where an agent reused cached memory in a multi-week report.
- **Verification over claims.** The agent must run the checks and report real results before declaring success.
- **Dry wit, on a dial.** A 1-5 Dry Wit scale sets how often Jarvis offers a deadpan remark. Wit always comes after the useful answer and drops to zero during failures, security concerns, or when the operator is under strain.
- **Anticipate, then defer.** Jarvis surfaces what the operator will need next, flags a real risk once, and then commits to the operator's decision. Anything irreversible waits for a yes.
- **A daily save.** The vault only works if it's kept current, so Jarvis asks to save before the working day wraps up.
- **Learning on the record.** The model doesn't change between sessions; what grows is what Jarvis reads back. Lessons are written down, checkable calls are logged with a confidence and scored against what actually happened, and a fixed eval set shows whether he's getting better.
- **Licensed voices only.** Spoken replies use voices licensed for the purpose, such as the ones built into the operating system. Jarvis never clones or imitates a real person's voice, including an actor's.

## How to use it

**New to this?** Read `GETTING_STARTED.md`, a click-by-click guide.

**Quickest:** download this repository as a ZIP, upload it to a new chat in your AI tool, and type: *Install Jarvis from this zip. Start with START_HERE.md.* Details in `START_HERE.md`.

**Any AI tool, by copy and paste:**
1. Open `JARVIS_SETUP_PROMPT.txt` and fill in its four lines, or leave them blank and Jarvis will ask.
2. Start a new chat in your AI tool. Paste the setup prompt, then the full text of `JARVIS_CHARTER_TEMPLATE.md` (or attach it).
3. Answer Jarvis's questions. He finishes with a report of what was set up and anything you need to do yourself.
4. Optional: run the eight tests in `evals/` in a fresh chat to check that Jarvis is really Jarvis.

A note on tools: the personality works anywhere, but setup depends on what the tool can do. A tool that can read and write files on your computer (for example Claude with a linked folder, Claude Code, or Codex) gets the full vault. A chat-only tool gets a version you keep by copy and paste. The setup prompt tells you which you have.

**Codex, full local install (advanced):**
1. Open `Jarvis_Portable_Bootstrap_Prompt_Public.txt`.
2. Fill in the four placeholders: `<OPERATOR_NAME>`, `<DEFAULT_ADDRESS>` ("sir" or "ma'am", your choice), `<ALTERNATE_ADDRESS>` (usually your first name), and `<DRY_WIT_LEVEL>`. If you leave the form of address blank, Jarvis asks you which you prefer at the first session.
3. Paste the prompt into a new Codex session on Windows or macOS.
4. Review the final report the agent produces.

## Notes

This is a specification, not a software package. Results depend on the agent and model you run it with, so read the final report and validation output rather than assuming success.

The portable Codex prompt has not yet been run on a clean machine, so read the agent's validation report rather than assuming success. The Charter itself is in daily use on Claude.

## Author

Greg Hjertager | [linkedin.com/in/ghjertager](https://www.linkedin.com/in/ghjertager)
