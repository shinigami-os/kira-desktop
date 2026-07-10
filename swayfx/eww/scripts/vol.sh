#!/bin/sh
# Volume as whole percentage. Returns "0" muted, numeric otherwise, "0" on failure.
out=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null)
if [ -z "$out" ]; then
  echo 0
  exit 0
fi
case "$out" in
  *MUTED*) echo 0 ;;
  *) echo "$out" | awk '{printf "%d", $2*100}' ;;
esac
