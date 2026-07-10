#!/bin/sh
# RAM used as whole percentage
awk '/MemTotal/{t=$2} /MemAvailable/{a=$2} END{printf "%d\n", (t-a)/t*100}' /proc/meminfo
