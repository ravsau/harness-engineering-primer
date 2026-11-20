---
name: add-flagged-word
description: Add a new flagged word or phrase to the post checker and check on the page that it works. Use when I ask to flag a new word or phrase.
---

# Add a flagged word

Do these steps for the given word or phrase.

1. Add the word or phrase to `voice.md` and to `BANNED` in `checker.js`. Keep both lists the same.

2. Take a screenshot of the page with a sample post that uses the new word, using the installed Chrome:

   ```bash
   "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --headless=new --hide-scrollbars --window-size=800,700 --screenshot="$PWD/shot.png" "file://$PWD/index.html?text=<the post, URL-encoded>"
   ```

3. Open `shot.png` and check that:
   - the word is in the "Flagged:" line,
   - the legend lists the word,
   - the yellow highlight covers exactly the word, no letter missing and no extra letter.

4. If a check fails, fix the code and take a new screenshot.

5. Report what changed, what you checked on the screenshot, and what you could not check. Do not claim a check you did not do.
