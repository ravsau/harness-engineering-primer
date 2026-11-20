# Prompts, lesson by lesson

Copy the prompts for each lesson from here. Lessons 1 and 9 have no prompts.

## 2. The agent only knows what it can read

Lesson 2. Type each prompt into Claude Code in this order (paste the sample post into the page; `/clear` before the second question).

```
The kicker? Our new setup is a game-changer—it wasn't just faster, it cut our AI bill in half. https://cloudyeti.io/blog/how-we-cut-our-ai-bill 👍
```

```
Do not change any file. Which words and phrases do I never want in my posts? Use only the files in this repo. If the files disagree or you cannot know, say so.
```

```
Create voice.md with this text, exactly:

# Voice rules for posts

Words and marks I never use. The post checker flags each one.

- em dash (—): use a comma or a period instead
- the kicker?
- the real issue?
- it wasn't just
- game-changer
- delve

Limits (X, from https://docs.x.com/resources/fundamentals/counting-characters, read 2026-11-15):
- A post can have up to 280 characters.
- Every link counts as 23 characters, whatever its length.
- Every emoji counts as 2 characters.
```

```
Make the code match voice.md: one banned list, in checker.js, and the page legend shows that list. Change nothing else.
```

## 3. Keep AGENTS.md short

Lesson 3. Run each prompt in order; type `/clear` before the last one.

```
! wc -l AGENTS.md
```

```
Do not change any file, and do not look at the code. From AGENTS.md only: what is the character limit for a post, how do I run the tests, and what language is this project written in?
```

```
Check each rule in AGENTS.md against the files in this repo. Rewrite AGENTS.md in 15 lines or fewer, with only what is true today. It must say: the banned words and the counting rules live in voice.md, never add one from memory; the page is index.html and the logic is checker.js; no packages and no build step. Do not list bugs in AGENTS.md. Then tell me what you dropped, in five lines.
```

```
Do not change any file. I want to ban the word 'synergy' in my posts. Which file or files do I change, and why?
```

## 4. Skills

Lesson 4. Run each prompt in order; the skill-creation prompt is one long line.

```
This product is revolutionary and groundbreaking.
```

```
Add revolutionary to the flagged words.
```

```
Create a skill at .claude/skills/add-flagged-word/SKILL.md. Frontmatter: name: add-flagged-word, description: Add a new flagged word or phrase to the post checker and check on the page that it works. Use when I ask to flag a new word or phrase. Steps, for the given word or phrase: 1. Add it to voice.md and to BANNED in checker.js. Keep both lists the same. 2. Take a screenshot of the page with a sample post that uses the new word, using the installed Chrome: "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --headless=new --hide-scrollbars --window-size=800,700 --screenshot="$PWD/shot.png" "file://$PWD/index.html?text=<the post, URL-encoded>". 3. Open shot.png and check that the word is in the "Flagged:" line, the legend lists the word, and the yellow highlight covers exactly the word, no letter missing and no extra letter. 4. If a check fails, fix the code and take a new screenshot. 5. Report what changed, what you checked on the screenshot, and what you could not check. Do not claim a check you did not do. That is the end of the skill. After you create the file, do not run or test anything, and reply in one line.
```

```
/reload-skills
```

```
/add-flagged-word groundbreaking
```

## 5. Unit tests

Lesson 5. Paste the post from lesson 2 into the page first, then run each prompt in order.

```
Write checker.test.js with Node's built-in test runner, no packages. Take the cases from the rules in voice.md: "hello" counts 5; "see https://example.com/a/very/long/path/to/a/page" counts 27; "ok 👍" counts 5; "Let's Delve in" flags delve; "The kicker? It worked." flags "the kicker?" as one item; "fast—cheap" flags the em dash; "We cut our AI bill by 40% this month." has no flags. Run node --test. Do not fix anything yet.
```

```
Fix checker.js until node --test passes. Do not change the tests or index.html.
```

```
In AGENTS.md, replace the line that says there is no test suite with: "Tests: node --test. Run them before you say a change is done." Change nothing else.
```

## 6. Stop hook

Lesson 6. Copy the hook file first, then run each prompt; restart `claude` and type `/hooks` after registering the hook.

```
mkdir -p .claude/hooks && cp ../harness-engineering-primer/kit/stop-check.cjs .claude/hooks/
```

```
I delve into this, and then I delve again.
```

```
Register .claude/hooks/stop-check.cjs as a Stop hook in .claude/settings.json. Change nothing else.
```

```
Add one unit test to checker.test.js: "delve, then delve again" has 2 flags. Do not run the tests.
```

## 7. Handoff notes

Lesson 7. Run each prompt in order; type `/exit` and restart `claude` before `/handoff resume red-counter`.

```
We moved our nightly reports from one large model to a small model with a cache in front of it. The small model answers nine out of ten questions, and the large model only gets the hard ones. Our AI bill went down, the answers stayed the same, and nobody on the team noticed the switch for two weeks.
```

```
A post longer than 280 characters should show the count in red. It does not. Find out why. Do not fix it.
```

```
/handoff red-counter
```

```
The title and the tagline in index.html must follow voice.md too. Find the words in them that break voice.md. Do not fix them.
```

```
/handoff page-text
```

```
/handoff resume red-counter
```

```
Yes, fix it.
```

```
Create a skill at .claude/skills/handoff/SKILL.md. The skill has two uses. "/handoff <name>" writes a note at handoffs/<name>-<date and time>.md with four headings: Status, What changed, Not checked, Next. "/handoff resume <name>" reads the newest note for that name, checks that the files the note names still match the note, and tells me the next step before it changes anything.
```

## 8. Tools

Lesson 8. This lesson has no demo prompts. The command form to try:

```
claude mcp add --transport http <name> <url>
```
