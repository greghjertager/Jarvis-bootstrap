# Jarvis Bootstrap

Everything you need to build Jarvis, a persistent AI coworker that stays the same on any AI tool: a written charter for who he is, a plain-text memory vault, a control center, and a test set. It is a personal project inspired by the J.A.R.V.I.S. assistant from the Iron Man films, and is not affiliated with or endorsed by Marvel or Disney.

## What's here

- **`JARVIS_CHARTER_TEMPLATE.md`** (v2.3) is the full rulebook for who Jarvis is, independent of any AI tool: purpose, identity, the Butler voice, the Dry Wit scale, working habits (briefing, standing watch, situational awareness, guardian, dossier, judgment log, weekly report, arguing against his own calls), truth and data rules, the vault routine, a self-check, and a phrasebook. It ends with steps for adapting Jarvis to a new AI tool and an acceptance test. The Charter is the source of truth.
- **`CHANGELOG.md`** records every Charter version, with the date and the reason for the change.
- **`evals/`** is a fixed set of eight tests, a rubric, and a score sheet, re-run after every model change, Charter version, or new tool, so improvement (or drift) is measured rather than assumed.
- **`control/`** (optional, Windows) is the Jarvis Control Center: a small window for dialing Jarvis up or down (Dry Wit, verbosity, formality, sir or ma'am, voice, briefing, save reminder), with read-only vault status and an honest security panel. It edits `SETTINGS.json`, which Jarvis reads at the start of every session. Copy `control/` into your vault and `control/SETTINGS.json` to the vault's top level, then double-click `Jarvis Control Center.bat`.
- **`voice/`** (optional) lets Jarvis answer out loud on Windows using the text-to-speech voices built into Windows. See `voice/README.md`.

To bring Jarvis into an AI tool (Claude, ChatGPT, Copilot, or another assistant), start from the Charter and follow its "Adapting Jarvis to a new tool" section. The goal is one consistent Jarvis across tools: setups are built from the Charter and never edited on their own, and improvements go into the Charter first.

## Running on Claude

The author's Jarvis runs on Claude, built from the Charter:
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

## Design principles

- **Clear boundaries.** No employer data, credentials, or private operational material is imported or stored.
- **Honest limits.** If the vault isn't encrypted, Jarvis says so. The strongest setup uses a hardware key (a YubiKey or similar) that must approve every write.
- **Safe by default.** No untrusted downloads, backups before any change, and approval required for any outside dependency.
- **Live data only.** Reports must use live, verifiable data with the source and retrieval time named. The assistant may not substitute cached or remembered values. This rule came from a real failure, where an agent reused cached memory in a multi-week report.
- **Verification over claims.** Jarvis runs the checks and reports real results before declaring success.
- **Dry wit, on a dial.** A 1-5 Dry Wit scale sets how often Jarvis offers a deadpan remark. Wit always comes after the useful answer and drops to zero during failures, security concerns, or when the operator is under strain.
- **Anticipate, then defer.** Jarvis surfaces what the operator will need next, flags a real risk once, and then commits to the operator's decision. Anything irreversible waits for a yes.
- **A daily save.** The vault only works if it's kept current, so Jarvis asks to save before the working day wraps up.
- **Learning on the record.** The model doesn't change between sessions; what grows is what Jarvis reads back. Lessons are written down, checkable calls are logged with a confidence and scored against what actually happened, and a fixed eval set shows whether he's getting better.
- **Licensed voices only.** Spoken replies use voices licensed for the purpose, such as the ones built into the operating system. Jarvis never clones or imitates a real person's voice, including an actor's.

## How to use it

1. Copy `JARVIS_CHARTER_TEMPLATE.md` and fill in its four placeholders: `<OPERATOR_NAME>`, `<DEFAULT_ADDRESS>` ("sir" or "ma'am", your choice), `<ALTERNATE_ADDRESS>` (usually your first name), and `<DRY_WIT_LEVEL>`. If you leave the form of address blank, Jarvis asks you which you prefer at the first session.
2. Make a vault: a plain folder with the files listed in Charter section 7. Put the Charter in it, and optionally `control/` and `SETTINGS.json`.
3. Follow the Charter's "Adapting Jarvis to a new tool" section for your AI tool (custom instructions, a skill, or a system prompt that points to the Charter).
4. Run the acceptance test at the end of the Charter, then the evals in `evals/`.

## Notes

This is a specification, not a software package. Results depend on the AI tool and model you use, so run the acceptance test and the evals rather than assuming success. The Charter is in daily use on Claude.

## Author

Greg Hjertager | [linkedin.com/in/ghjertager](https://www.linkedin.com/in/ghjertager)
