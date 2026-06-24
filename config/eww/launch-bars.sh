#!/bin/sh
sleep 2
eww kill 2>/dev/null

monitors=$(swaymsg -t get_outputs | grep -c '"active": true')

i=0
while [ "$i" -lt "$monitors" ]; do
    eww open bar
    i=$((i + 1))
done