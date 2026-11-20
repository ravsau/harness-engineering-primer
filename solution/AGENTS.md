# AGENTS.md

Post Checker shows how many characters an X post uses and flags banned words before you post it.

- `index.html` is the page. `checker.js` holds the logic: `BANNED`, `LIMIT`, `countX`, `findBanned`.
- No packages and no build step. To run it, open `index.html` in a browser.
- `index.html?text=your%20post` opens the page with a draft filled in.
- Tests: node --test. Run them before you say a change is done.
- The banned words and the counting rules live in `voice.md`. Never add a word or a rule from memory.
- `BANNED` in `checker.js` is the only copy of the list in code, and the page legend reads from it.
  Keep `BANNED` the same as `voice.md`, and ask before you change either one.
- Page text follows `voice.md` too: say "post", and use no em dashes.
