#!/bin/sh
st=$(playerctl status 2>/dev/null || echo Stopped)
ti=$(playerctl metadata title 2>/dev/null | head -c 48)
ar=$(playerctl metadata artist 2>/dev/null | head -c 36)
pos=$(playerctl metadata --format '{{position/1000000}}' 2>/dev/null | cut -d. -f1); : "${pos:=0}"
len=$(playerctl metadata --format '{{mpris:length/1000000}}' 2>/dev/null | cut -d. -f1); : "${len:=0}"
pct=0; [ "$len" -gt 0 ] 2>/dev/null && pct=$((pos * 100 / len))
fmt() { printf '%d:%02d' $(($1/60)) $(($1%60)); }
g=$(printf '%s' "${ar:-mu}" | cut -c1-2 | tr '[:upper:]' '[:lower:]')
jq -cn --arg s "$st" --arg t "${ti:-nothing playing}" --arg a "$ar" \
  --arg g "${g:-mu}" --arg p "$(fmt "$pos")" --arg l "$(fmt "$len")" --argjson pc "$pct" \
  '{status:$s,title:$t,artist:$a,glyph:$g,pos:$p,len:$l,pct:$pc}'
