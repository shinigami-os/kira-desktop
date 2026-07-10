#!/bin/sh
# toast.sh vol | bri | <free text>
cd "$(dirname "$0")/.." || exit 1
case "$1" in
  vol) v=$(sh scripts/vol.sh); txt="vol ${v}%" ;;
  bri) v=$(sh scripts/bri.sh); txt="bri ${v}%" ;;
  *)   txt="$*" ;;
esac
eww update toasttxt="$txt" 2>/dev/null
eww open toast 2>/dev/null
echo $$ > /tmp/kira-toast.pid
( sleep 1.6
  [ "$(cat /tmp/kira-toast.pid 2>/dev/null)" = "$$" ] && eww close toast 2>/dev/null ) &
