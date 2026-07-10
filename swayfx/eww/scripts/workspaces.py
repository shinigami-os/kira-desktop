#!/usr/bin/env python3
import sys, json, os, glob, time

CW, CH, INSET = 34, 22, 3
OUT = "/tmp/kira-ws"

def build_svg(wins):
    iw, ih = CW - 2*INSET, CH - 2*INSET
    rects = []
    for r in wins:
        x = INSET + r["l"]/100.0*iw
        y = INSET + r["t"]/100.0*ih
        w = max(2, r["w"]/100.0*iw)
        h = max(2, r["h"]/100.0*ih)
        if r.get("f"):
            fill, fo, stroke, so = "#aa00ff", "0.26", "#aa00ff", "0.75"
        else:
            fill, fo, stroke, so = "#e8d8ff", "0.09", "#e8d8ff", "0.25"
        rects.append(
            f'<rect x="{x:.1f}" y="{y:.1f}" width="{w:.1f}" height="{h:.1f}" '
            f'fill="{fill}" fill-opacity="{fo}" stroke="{stroke}" '
            f'stroke-opacity="{so}" stroke-width="1"/>'
        )
    return (f'<svg width="{CW}" height="{CH}" viewBox="0 0 {CW} {CH}" '
            f'xmlns="http://www.w3.org/2000/svg">{"".join(rects)}</svg>')

raw = sys.stdin.read()
gen = int(time.time() * 1000) % 100000000

os.makedirs(OUT, exist_ok=True)

def emit(entries):
    # write new files, then remove stale generations
    for e in entries:
        path = f"{OUT}/ws{e['num']}-{gen}.svg"
        with open(path, "w") as f:
            f.write(e.pop("_svg"))
        e["img"] = path
    for old in glob.glob(f"{OUT}/ws*-*.svg"):
        if f"-{gen}.svg" not in old:
            try: os.remove(old)
            except OSError: pass
    print(json.dumps(entries), flush=True)

try:
    ws_str, tree_str = raw.split("\037", 1)
    workspaces = json.loads(ws_str)
    tree = json.loads(tree_str)
except Exception:
    emit([{"num": n, "focused": n == 1, "_svg": build_svg([])} for n in range(1, 6)])
    sys.exit(0)

active = {w.get("num"): w.get("focused", False) for w in workspaces}

def walk_ws(node, acc):
    if node.get("type") == "workspace" and node.get("num", -1) != -1:
        acc.append(node); return
    for c in node.get("nodes", []) + node.get("floating_nodes", []):
        walk_ws(c, acc)

def leaves(node):
    res = []
    kids = node.get("nodes", []) + node.get("floating_nodes", [])
    if not kids and node.get("type") in ("con", "floating_con") and node.get("name") is not None:
        res.append(node)
    for c in kids:
        res.extend(leaves(c))
    return res

ws_nodes = []
for output in tree.get("nodes", []):
    walk_ws(output, ws_nodes)

geo = {}
for ws in ws_nodes:
    wr = ws.get("rect", {"x":0,"y":0,"width":1,"height":1})
    W = wr.get("width",1) or 1
    H = wr.get("height",1) or 1
    X0, Y0 = wr.get("x",0), wr.get("y",0)
    wins = []
    for leaf in leaves(ws)[:3]:
        lr = leaf.get("rect", {})
        l = max(0, min(round((lr.get("x",X0)-X0)/W*100), 100))
        t = max(0, min(round((lr.get("y",Y0)-Y0)/H*100), 100))
        w = max(8, min(round(lr.get("width",0)/W*100), 100))
        h = max(8, min(round(lr.get("height",0)/H*100), 100))
        wins.append({"l":l,"t":t,"w":w,"h":h,"f":1 if leaf.get("focused") else 0})
    geo[ws.get("num")] = wins

entries = []
for n in range(1, 6):
    entries.append({
        "num": n,
        "focused": active.get(n, False),
        "_svg": build_svg(geo.get(n, [])),
    })
emit(entries)
