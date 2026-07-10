#!/bin/sh
awk '{s=int($1); d=int(s/86400); h=int((s%86400)/3600); printf "up %dd %dh\n", d, h}' /proc/uptime
