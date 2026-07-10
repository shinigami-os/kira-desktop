#!/bin/sh
# Flash the ghost digit once per workspace switch.
cd "$(dirname "$0")/.." || exit 1

LOCK=/tmp/kira-ghost.pid
if [ -f "$LOCK" ] && kill -0 "$(cat "$LOCK" 2>/dev/null)" 2>/dev/null; then
  exit 0
fi
echo $$ > "$LOCK"
trap 'rm -f "$LOCK"' EXIT

last=""
lastts=0
swaymsg -t subscribe '["workspace"]' -m 2>/dev/null | while IFS= read -r _; do
  num=$(swaymsg -t get_workspaces 2>/dev/null | jq -r '.[] | select(.focused) | .num' 2>/dev/null)
  [ -z "$num" ] && continue
  now=$(date +%s)
  if [ "$num" = "$last" ] && [ $((now - lastts)) -le 1 ]; then continue; fi
  last="$num"; lastts="$now"
  # close first so the window is always freshly created -> animation replays
  eww close ghost-ws 2>/dev/null
  eww update ghostnum="$num" 2>/dev/null
  eww open ghost-ws 2>/dev/null
  sleep 0.9
  eww close ghost-ws 2>/dev/null
done
