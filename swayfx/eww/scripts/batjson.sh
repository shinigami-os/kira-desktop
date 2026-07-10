#!/bin/sh
# Emit {"present":bool,"charging":bool,"low":bool,"pct":N,"cells":[1,1,1,0,0]}
for d in /sys/class/power_supply/BAT*; do
  [ -r "$d/capacity" ] || continue
  read -r pct < "$d/capacity"
  read -r st  < "$d/status" 2>/dev/null || st="Unknown"
  chg=false; [ "$st" = "Charging" ] && chg=true
  low=false; [ "$pct" -le 20 ] && [ "$chg" = "false" ] && low=true
  filled=$(( (pct * 5 + 50) / 100 ))          # round(pct/100*5)
  [ "$chg" = "true" ] && [ "$filled" -lt 1 ] && filled=1
  [ "$filled" -gt 5 ] && filled=5
  cells=""
  i=1
  while [ $i -le 5 ]; do
    v=0; [ $i -le $filled ] && v=1
    cells="$cells$v"; [ $i -lt 5 ] && cells="$cells,"
    i=$((i+1))
  done
  printf '{"present":true,"charging":%s,"low":%s,"pct":%s,"cells":[%s]}\n' "$chg" "$low" "$pct" "$cells"
  exit 0
done
echo '{"present":false,"charging":false,"low":false,"pct":0,"cells":[0,0,0,0,0]}'
