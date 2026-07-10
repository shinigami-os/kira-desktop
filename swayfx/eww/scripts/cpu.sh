#!/bin/sh
# Instantaneous CPU load %.
read -r _ a b c idle _ < /proc/stat
p_tot=$((a+b+c+idle)); p_idle=$idle
sleep 0.3
read -r _ a b c idle _ < /proc/stat
tot=$((a+b+c+idle))
dt=$((tot-p_tot)); di=$((idle-p_idle))
[ "$dt" -eq 0 ] && { echo 0; exit; }
echo $(( (100*(dt-di)) / dt ))
