#!/bin/sh
awk '{s=int($1); h=int(s/3600); min=int((s%3600)/60); printf "up %dh %dmin\n", h, , min}' /proc/uptime
