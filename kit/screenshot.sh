#!/bin/sh
# screenshot.sh "post text" [out.png]: opens index.html in headless Chrome with the text filled in and saves a screenshot.
# Uses your installed Google Chrome; downloads nothing.
CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
TEXT=$(node -e 'process.stdout.write(encodeURIComponent(process.argv[1]))' "$1")
OUT="${2:-shot.png}"
"$CHROME" --headless=new --disable-gpu --hide-scrollbars --window-size=800,700 \
  --screenshot="$PWD/$OUT" "file://$PWD/index.html?text=$TEXT" 2>/dev/null
echo "Saved $OUT"
