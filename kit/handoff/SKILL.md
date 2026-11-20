---
name: handoff
description: Write or resume a session handoff. Write mode saves a detailed handoffs/<ID>-<date>.md for an unfinished task and appends one line to progress.txt. Resume mode finds the newest handoff for a task, checks it against git, and proposes the next step. Use for "/handoff", "handoff", "write a handover", "context is filling up", "end session", "/handoff resume <ID>", "resume handoff", "pick up where we left off".
---

# Handoff

Two modes. `/handoff [ID]` writes. `/handoff resume [ID|path]` resumes.
Pattern: Anthropic progress file + HumanLayer create_handoff/resume_handoff, simplified.
Files live in the repo root: `progress.txt` (index) and `handoffs/` (detail).

## Write mode

1. ID = a short name for the task, in lowercase with hyphens, e.g. `red-counter`. If the project has task IDs, use the task ID.
2. Run `bash .claude/skills/handoff/handoff.sh meta <ID>`. It prints the file path, date, commit, branch.
3. Write the file at that path. More information, not less. Use `path:line` references, not big code blocks. Link decisions and plans; never copy them.

```markdown
---
task: <ID>
date: <iso>
commit: <hash>
branch: <branch>
---
# Handoff: <ID> <one-line description>
## Status        done / in progress / blocked, and which step
## What changed  path:line for each change this session
## Learnings     root causes, patterns, dead ends ("tried X, failed because Y")
## Not checked   claims or changes nobody verified
## Next          numbered, first item is where the next session starts
## Links         plans, decision IDs, docs to read first
```

4. Append one line to `progress.txt` (create it if missing):
   `YYYY-MM-DD HH:MM <commit> <ID> <passes|not done|blocked>. <one key fact> -> handoffs/<file>`
5. Reply with the resume command: `/handoff resume <ID>`.
Never edit an old handoff. Write a new one. No loop-run logs or decision reasoning in it.

## Resume mode

1. Find it: a path given -> use it. An ID -> `bash .claude/skills/handoff/handoff.sh latest <ID>`. Nothing given -> show the last 10 lines of `progress.txt` and ask which.
2. Read the handoff in full yourself (no subagent, no offset/limit), then the files under Links.
3. Check it against the code: `bash .claude/skills/handoff/handoff.sh drift <file>` prints the commits since the handoff and which of its named files changed. Confirm `path:line` refs still exist. Re-run anything under "Not checked" that the next step builds on.
4. Report, briefly:
   - Status then -> now (still holds / changed / missing)
   - Learnings still valid?
   - Drift: N commits since, files touched
   - Proposed next step (Next item 1, or a new plan if stale)
5. Wait for a yes, then start. If the code moved on or the task changed, say the handoff is stale and plan fresh.
Rule: never assume the handoff matches the current code.

## Example

`/handoff red-counter` -> `handoffs/red-counter-2026-11-16-0940.md` +
`2026-11-16 09:40 abc123 red-counter not done. Cause found, not fixed -> handoffs/red-counter-2026-11-16-0940.md`
Next session: `/handoff resume red-counter` -> reads that file, 3 commits since, 1 named file changed, proposes Next item 1.
