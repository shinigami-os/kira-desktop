#!/bin/sh
emit() {
  status=$(playerctl status 2>/dev/null || echo "Stopped")
  title=$(playerctl metadata title 2>/dev/null | tr -d '\r' | head -c 60)
  artist=$(playerctl metadata artist 2>/dev/null | tr -d '\r' | head -c 40)
  jq -cn --arg s "$status" --arg t "$title" --arg a "$artist" '{status:$s, title:$t, artist:$a}'
}
emit
playerctl -F metadata --format '{{status}}' 2>/dev/null | while read -r _; do emit; done
