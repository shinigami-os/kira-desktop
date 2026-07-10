#!/bin/sh
# Emit [{g,t,b,time}] from mako history (newest first, max 8).
makoctl history 2>/dev/null | jq -c '[.data[0][:8][] | {
  g: ((.["app-name"].data // "sy")[0:2]),
  t: (.summary.data // "notification"),
  b: (.body.data // ""),
  time: "·"
}]' 2>/dev/null || echo "[]"
