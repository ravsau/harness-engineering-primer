# Harness Engineering Primer: course files

Companion files for the CloudYeti **Harness Engineering Primer** video course.
You use a coding agent you already have (Claude Code, Codex, Cursor, Antigravity). Claude Code and Codex already give you a harness. In this course you add your own layer around it: files and checks for one small micro app, a **post checker** (paste a post for X, see the character count and the words you never want to use).

## What you need
- Claude Code (2.1.277 or later) or Codex CLI, signed in with your own account. Exercises use your plan's normal usage.
- Node.js 20 or later (for the tests and checks; no packages to install).
- Google Chrome (the screenshot script uses your installed Chrome in headless mode).
- A web browser.

## How to use this repo
- The lessons start from a small starter app. Clone it: https://github.com/ravsau/post-checker-demo. Then follow the lessons in that folder and copy the prompts from [PROMPTS.md](PROMPTS.md), lesson by lesson.
- `kit/` holds the files you copy in during the course: `add-flagged-word/SKILL.md` (the skill from lesson 4), `screenshot.sh` (the screenshot step of that skill as a script), `stop-check.cjs` (the Stop hook, lesson 6) and `handoff/` (the handoff skill: `SKILL.md` and `handoff.sh`, lesson 7).
- `solution/` is the post checker as it is at the end of lesson 7: `voice.md`, `AGENTS.md`, `checker.js`, `checker.test.js` (8 unit tests) and `index.html`. Run `node --test` inside it, or open `index.html`.
- Tools (lesson 8): this repo has no `.mcp.json`. Lesson 8 is an idea lesson with a command to try: `claude mcp add --transport http <name> <url>`.

## What you add, lesson by lesson
| Lesson | Added to the harness |
|---|---|
| 1 Agent = model + harness | (idea only) |
| 2 The agent only knows what it can read | `voice.md` |
| 3 Keep AGENTS.md short | `AGENTS.md` |
| 4 Skills | a skill, `.claude/skills/add-flagged-word/SKILL.md` (from `kit/add-flagged-word/`) |
| 5 Unit tests | `checker.test.js` |
| 6 Stop hook | `.claude/hooks/stop-check.cjs` (from `kit/`) + `.claude/settings.json` |
| 7 Handoff notes | the `handoff` skill (from `kit/handoff/`), `handoffs/`, `progress.txt` |
| 8 Tools | MCP servers and API keys in a `.env` file (idea lesson, no files in this repo) |
| 9 Your own project | the seven pieces on your own repo |

The X counting rules in `solution/voice.md` (280 characters, links count 23, emoji count 2) come from https://docs.x.com/resources/fundamentals/counting-characters, read 2026-11-15. `checker.js` uses a simplified version of them.

## Sources
See [SOURCES.md](SOURCES.md).

License: MIT.
