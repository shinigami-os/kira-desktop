#!/bin/sh
# deflisten source: emits progressively-typed voice lines (model: 60ms/char).
# voice.sh --say "..."  queues a line immediately (used by easter eggs/idle).
cd "$(dirname "$0")/.." || exit 1

SKIP=/tmp/kira-voice-skip
OVR=/tmp/kira-voice-override

if [ "$1" = "--say" ]; then
  printf '%s\n' "$2" > "$OVR"
  touch "$SKIP"
  exit 0
fi

pkgs=$(sh scripts/pkgs.sh 2>/dev/null); : "${pkgs:=some}"

nth() {
  case $(( $1 % 8 )) in
    0) echo "all quiet. i checked twice." ;;
    1) echo "uptime $(sh scripts/uptime.sh 2>/dev/null | sed 's/^up //'). impressive. concerning." ;;
    2) echo "$pkgs packages. each one earned its place." ;;
    3) echo "your cpu is bored. compile something." ;;
    4) echo "swappiness is 10, as it should be." ;;
    5) echo "rolling release. never falling." ;;
    6) echo "i logged nothing today. you are welcome." ;;
    7) echo "the terminal misses you." ;;
  esac
}

i=0
while :; do
  if [ -f "$OVR" ]; then
    line=$(cat "$OVR"); rm -f "$OVR"
  else
    line=$(nth $i); i=$((i + 1))
  fi
  len=${#line}
  k=1
  while [ "$k" -le "$len" ]; do
    if [ -f "$SKIP" ]; then rm -f "$SKIP"; break; fi
    printf '%s\n' "$(printf '%s' "$line" | cut -c1-"$k")"
    k=$((k + 1))
    sleep 0.06
  done
  # hold the finished line ~25s; skip or override interrupts the hold
  t=0
  while [ "$t" -lt 250 ]; do
    [ -f "$SKIP" ] && { rm -f "$SKIP"; break; }
    [ -f "$OVR" ] && break
    sleep 0.1
    t=$((t + 1))
  done
done
