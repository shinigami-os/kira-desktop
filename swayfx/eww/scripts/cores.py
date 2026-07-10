#!/usr/bin/env python3
import time, json
def snap():
    d = {}
    with open("/proc/stat") as f:
        for line in f:
            p = line.split()
            if p and p[0].startswith("cpu") and p[0] != "cpu":
                vals = list(map(int, p[1:8]))
                d[p[0]] = (sum(vals), vals[3])
    return d
a = snap(); time.sleep(0.25); b = snap()
out = []
for k in sorted(a, key=lambda x: int(x[3:])):
    dt = b[k][0] - a[k][0]; di = b[k][1] - a[k][1]
    out.append(round(100 * (dt - di) / dt) if dt else 0)
print(json.dumps(out))
