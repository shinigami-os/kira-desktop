#!/bin/sh
# Append CPU sample to 24-slot ring, render small island sparkline to stable path.
HIST=/tmp/kira_cpuhist24
OUT=/tmp/kira-sys
FILE="$OUT/spark-small.svg"
mkdir -p "$OUT"

cur=$(sh scripts/cpu.sh 2>/dev/null)
case "$cur" in ''|*[!0-9]*) cur=0 ;; esac
echo "$cur" >> "$HIST"
tail -n 24 "$HIST" > "$HIST.tmp" && mv "$HIST.tmp" "$HIST"

awk -v out="$FILE" '
{ v[NR]=$1 }
END {
  n=NR; start=(n<24?24-n:0); line=""
  for (i=0;i<24;i++){
    idx=i-start+1
    val=(idx>=1&&idx<=n)?v[idx]:0
    x=i*(46.0/23.0); y=18-(val/100.0)*16
    if(y<1)y=1; if(y>18)y=18
    line=line sprintf("%.1f,%.1f ",x,y)
  }
  printf "<svg width=\"46\" height=\"20\" viewBox=\"0 0 46 20\" xmlns=\"http://www.w3.org/2000/svg\">" > out
  printf "<polyline points=\"%s\" fill=\"none\" stroke=\"#aa00ff\" stroke-width=\"1.4\" stroke-linejoin=\"round\"/>", line >> out
  printf "</svg>" >> out
}' "$HIST"
printf '%s\n' "$FILE"
