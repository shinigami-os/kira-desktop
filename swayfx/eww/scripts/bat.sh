#!/bin/sh
# Battery percentage, or -1 if no battery present.
for b in /sys/class/power_supply/BAT*/capacity; do
  [ -r "$b" ] || continue
  read -r cap < "$b"
  echo "$cap"
  exit 0
done
echo "-1"
