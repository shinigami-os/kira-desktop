#!/bin/sh
# Emit {num,name} of focused workspace.
nick() {
  case "$1" in
    1) echo "the usual" ;;
    2) echo "reading" ;;
    3) echo "split brain" ;;
    4) echo "empty. suspicious." ;;
    5) echo "side quest" ;;
    *) echo "workspace $1" ;;
  esac
}
emit() {
  num=$(swaymsg -t get_workspaces 2>/dev/null | jq -r '.[] | select(.focused) | .num' 2>/dev/null)
  [ -z "$num" ] && num=1
  printf '{"num":%s,"name":"%s"}\n' "$num" "$(nick "$num")"
}
emit
swaymsg -t subscribe '["workspace"]' -m 2>/dev/null | while IFS= read -r _; do emit; done
