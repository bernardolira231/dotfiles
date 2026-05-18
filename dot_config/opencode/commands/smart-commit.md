---
description: Create semantic English commits safely
---

Group all current changes into meaningful semantic commits.

Optional context for commit messages: `$ARGUMENTS`

RULES

First inspect the full repository state:
- `git status --short`
- `git diff --stat`
- `git diff`
- `git log --oneline -10`

If the current repository is `evoadmin-service`, NEVER stage or commit files named `appsettings.Development.json` or `Evoadmin.Pdf.csproj`, because they contain local-only changes.

Identify related file groups by intent: feature, fix, refactor, tests, docs, chore, release, or config.
Create multiple commits when there are independent changes. Do not mix unrelated changes in the same commit.
Every commit message must be in English.
Every commit message must start with a semantic prefix such as `feat:`, `fix:`, `refactor:`, `test:`, `docs:`, `chore:`, `build:`, or another accurate conventional type.
If `$ARGUMENTS` is not empty, use it as context to adjust commit messages, but do not force that text if it does not accurately describe the changes.
Use clear, semantic, concise commit messages that follow the repo's recent style.
Before committing, check for sensitive or suspicious files such as `.env`, tokens, credentials, keys, or secrets. If any appear, stop and ask before continuing.
Include new, modified, and deleted files that belong to each group.
Do not revert existing changes.
Do not use `--no-verify`.
Do not amend commits.
Do not force push.

FLOW

1. Show the proposed commit plan with the files included in each commit.
2. If the grouping is clear, continue. If there is real ambiguity, ask before committing.
3. For each group:
- Add only the files for that group with `git add <files>`.
- Create the commit with a semantic message.
4. Once all commits have been created, ask whether to push or not.
5. When finished, summarize the commits created and the branch used. If a new branch was created during the process, include it explicitly.
