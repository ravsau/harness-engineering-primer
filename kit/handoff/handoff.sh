#!/bin/bash
# Deterministic helpers for the handoff skill. No model calls.
#   handoff.sh meta <ID>      -> path, date, commit, branch for a new handoff
#   handoff.sh latest <ID>    -> newest handoffs/<ID>-*.md (exit 1 if none)
#   handoff.sh drift <file>   -> commits since the handoff's commit, named files that changed
set -euo pipefail
root=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
cmd=${1:-}; arg=${2:-}

case "$cmd" in
  meta)
    [ -n "$arg" ] || { echo "usage: handoff.sh meta <ID>" >&2; exit 2; }
    stamp=$(date '+%Y-%m-%d-%H%M')
    file="handoffs/${arg}-${stamp}.md"
    [ -e "$root/$file" ] && file="handoffs/${arg}-$(date '+%Y-%m-%d-%H%M%S').md"
    mkdir -p "$root/handoffs"
    echo "path: $file"
    echo "date: $(date '+%Y-%m-%dT%H:%M:%S%z')"
    echo "commit: $(git -C "$root" rev-parse --short HEAD 2>/dev/null || echo none)"
    echo "branch: $(git -C "$root" branch --show-current 2>/dev/null || echo none)"
    echo "uncommitted: $(git -C "$root" status --porcelain 2>/dev/null | wc -l | tr -d ' ') files"
    ;;
  latest)
    [ -n "$arg" ] || { echo "usage: handoff.sh latest <ID>" >&2; exit 2; }
    f=$(ls "$root/handoffs/${arg}-"*.md 2>/dev/null | sort | tail -1 || true)
    [ -n "$f" ] || { echo "no handoff for $arg in $root/handoffs/" >&2; exit 1; }
    echo "${f#$root/}"
    ;;
  drift)
    [ -f "$arg" ] || [ -f "$root/$arg" ] || { echo "no such file: $arg" >&2; exit 2; }
    f=$arg; [ -f "$f" ] || f="$root/$arg"
    c=$(awk '/^commit:/{print $2; exit}' "$f")
    if [ -z "$c" ] || ! git -C "$root" cat-file -e "$c^{commit}" 2>/dev/null; then
      echo "commit: unknown ($c) - cannot measure drift"; exit 0
    fi
    echo "handoff commit: $c"
    echo "commits since: $(git -C "$root" rev-list --count "$c..HEAD")"
    git -C "$root" log --oneline "$c..HEAD" | head -20
    echo "named files changed since (committed or not):"
    grep -oE '[A-Za-z0-9_./-]+\.[A-Za-z0-9]+' "$f" | grep -v '^handoffs/' | sort -u | while read -r p; do
      [ -e "$root/$p" ] || { case "$p" in */*) echo "  MISSING $p";; esac; continue; }
      if [ -n "$(git -C "$root" diff --name-only "$c" -- "$p" 2>/dev/null)" ]; then echo "  changed $p"; fi
    done
    ;;
  *) echo "usage: handoff.sh meta <ID> | latest <ID> | drift <file>" >&2; exit 2 ;;
esac
