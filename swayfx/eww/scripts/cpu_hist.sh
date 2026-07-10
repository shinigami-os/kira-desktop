#!/bin/sh
# Append CPU sample to 48-slot ring, render big sysmon SVG to a STABLE path.
HIST=/tmp/kira_cpuhist48
OUT=/tmp/kira-sys
FILE="$OUT/spark.svg"
mkdir -p "$OUT"

cur=$(sh /root/.config/eww/scripts/cpu.sh 2>/dev/null)
case "$cur" in ''|*[!0-9]*) cur=0 ;; esac
echo "$cur" >> "$HIST"
tail -n 48 "$HIST" > "$HIST.tmp" && mv "$HIST.tmp" "$HIST"

awk -v out="$FILE" '
{ v[NR]=$1 }
END {
  n=NR; start=(n<48?48-n:0); line=""
  for (i=0;i<48;i++){
    idx=i-start+1
    val=(idx>=1&&idx<=n)?v[idx]:0
    x=i*(382.0/47.0); y=84-(val/100.0)*80
    if(y<2)y=2; if(y>84)y=84
    line=line sprintf("%.1f,%.1f ",x,y)
  }
  printf "<svg width=\"382\" height=\"86\" viewBox=\"0 0 382 86\" xmlns=\"http://www.w3.org/2000/svg\">" > out
  printf "<polygon points=\"0,86 %s382,86\" fill=\"#aa00ff\" fill-opacity=\"0.12\"/>", line >> out
  printf "<polyline points=\"%s\" fill=\"none\" stroke=\"#aa00ff\" stroke-width=\"1.6\" stroke-linejoin=\"round\"/>", line >> out
  printf "</svg>" >> out
}' "$HIST"

printf '%s\n' "$FILE"
