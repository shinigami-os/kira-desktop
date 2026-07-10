#!/bin/sh
for f in /sys/class/thermal/thermal_zone*/temp; do
  read -r t < "$f" 2>/dev/null || continue
  echo $((t/1000)); exit 0
done
echo 0
