#!/usr/bin/env python3
import os, time, json

def sample():
    d = {}
    for pid in os.listdir("/proc"):
        if not pid.isdigit():
            continue
        try:
            with open(f"/proc/{pid}/stat") as f:
                parts = f.read().rsplit(")", 1)[1].split()
            d[pid] = int(parts[11]) + int(parts[12])  # utime + stime
        except Exception:
            pass
    return d

a = sample()
time.sleep(0.4)
b = sample()
hz = os.sysconf("SC_CLK_TCK") or 100

rows = []
for pid, t1 in b.items():
    t0 = a.get(pid)
    if t0 is None:
        continue
    pct = 100.0 * (t1 - t0) / (0.4 * hz)
    if pct <= 0:
        continue
    try:
        with open(f"/proc/{pid}/comm") as f:
            name = f.read().strip()[:10]
    except Exception:
        continue
    rows.append((pct, name))

rows.sort(reverse=True)
out = [{"n": n, "c": f"{p:.1f}%", "w": min(int(p), 100)} for p, n in rows[:6]]
# always emit at least an empty list
print(json.dumps(out))
