#!/bin/sh
# Emit workspace array with mini layouts: get_workspaces gives the reliable active flag, get_tree gives window geometry.
emit() {
  ws=$(swaymsg -t get_workspaces 2>/dev/null)
  tree=$(swaymsg -t get_tree 2>/dev/null)
  printf '%s\037%s' "$ws" "$tree" | python3 scripts/workspaces.py
}
emit
swaymsg -t subscribe '["workspace","window"]' -m 2>/dev/null | while IFS= read -r _; do
  emit
done
