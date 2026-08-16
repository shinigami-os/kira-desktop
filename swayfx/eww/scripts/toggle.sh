#!/bin/sh
# toggle.sh <name>   flips state file and applies side effects
S="/tmp/kira-toggles"; mkdir -p "$S"
f="$S/$1"
if [ -f "$f" ]; then rm -f "$f"; new=0; else : > "$f"; new=1; fi
case "$1" in
  dnd)
    if [ "$new" = 1 ]; then makoctl mode -a do-not-disturb >/dev/null 2>&1
    else makoctl mode -r do-not-disturb >/dev/null 2>&1; fi ;;
esac
eww update toggles="$(sh "$(dirname "$0")/toggles.sh")" 2>/dev/null
