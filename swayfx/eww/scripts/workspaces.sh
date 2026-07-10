#!/bin/sh
# Emit workspace array with mini layouts. Uses get_workspaces for the active
# flag (reliable) and get_tree for window geometry.
emit() {
  ws=$(swaymsg -t get_workspaces 2>/dev/null)
  tree=$(swaymsg -t get_tree 2>/dev/null)
  printf '%s\037%s' "$ws" "$tree" | python3 /root/.config/eww/scripts/workspaces.py
}
emit
swaymsg -t subscribe '["workspace","window"]' -m 2>/dev/null | while IFS= read -r _; do
  emit
done
