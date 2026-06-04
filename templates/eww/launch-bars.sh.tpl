#!/bin/sh
eww kill 2>/dev/null

monitors=$(swaymsg -t get_outputs | python3 -c "
import json,sys
outputs=json.load(sys.stdin)
print(len([o for o in outputs if o['active']]))
")

i=0
while [ "$i" -lt "$monitors" ]; do
    eww open bar --id "bar-$i" --arg "monitor=$i"
    i=$((i + 1))
done
