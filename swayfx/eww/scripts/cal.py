#!/usr/bin/env python3
import json, calendar, datetime
t = datetime.date.today()
calendar.setfirstweekday(calendar.MONDAY)
weeks = []
for wk in calendar.monthcalendar(t.year, t.month):
    row = []
    for d in wk:
        row.append({"t": str(d) if d else "", "today": d == t.day})
    weeks.append(row)
print(json.dumps({
    "month": t.strftime("%B").lower(),
    "year": str(t.year),
    "weeks": weeks,
    "foot": f"it's {t.strftime('%A').lower()}, {t.strftime('%B').lower()} {t.day}. you knew that.",
}))
