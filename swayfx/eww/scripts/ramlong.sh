#!/bin/sh
awk '/MemTotal/{t=$2} /MemAvailable/{a=$2} END{printf "%.1f / %.0f GiB\n", (t-a)/1048576, t/1048576}' /proc/meminfo
