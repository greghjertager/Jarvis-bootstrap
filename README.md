# Jarvis Bootstrap

A portable prompt that installs a persistent, local AI technical-coworker environment on a new machine. It is a personal project inspired by the J.A.R.V.I.S. assistant from the Iron Man films, and is not affiliated with or endorsed by Marvel or Disney.

## What it does

The prompt tells an AI coding agent to inspect the machine, back up anything it will change, and build the full environment, then verify the result:

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

## How to use it

1. Open `Jarvis_Portable_Bootstrap_Prompt_Public.txt`.
2. Fill in the three placeholders: `<OPERATOR_NAME>`, `<DEFAULT_ADDRESS>`, and `<ALTERNATE_ADDRESS>`.
3. Paste the prompt into a new Codex session on Windows or macOS.
4. Review the final report the agent produces.

## Notes

This is a specification, not a software package. Results depend on the agent and model you run it with, so read the final report and validation output rather than assuming success.

## Author

Greg Hjertager | [linkedin.com/in/ghjertager](https://www.linkedin.com/in/ghjertager)
