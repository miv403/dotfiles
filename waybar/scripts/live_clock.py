#!/usr/bin/env python3
import time
import subprocess
import json
import calendar
from datetime import datetime
from wcwidth import wcswidth

last_update = 0

def clamp_to_calendar_grid(text, max_width=21):
    """
    calendar.month() genişliği ~20-21 col.
    khal satırlarını buna uyduruyoruz.
    """
    out = []

    for line in text.splitlines():
        line = line.rstrip()
        if not line:
            continue

        current = ""
        width = 0

        for ch in line:
            w = wcswidth(ch)
            if w < 0:
                w = 1

            if width + w > max_width:
                current += "…"
                break

            current += ch
            width += w

        out.append(current)

    return "\n".join(out)

khal_month = None
khal_week = None

while True:
    now = datetime.now()
    current_time = time.time()

    if current_time - last_update > 300:

        khal_week = subprocess.getoutput("khal list now 7d")

        # GRID UYUMLU clamp (wrap değil!)
        khal_week = clamp_to_calendar_grid(khal_week, 19)

        khal_month = calendar.month(now.year, now.month)

        last_update = current_time

    out = {
        "text": now.strftime("%Y-%m-%d %H:%M:%S"),
        "tooltip": f"{khal_month}\nThis Week\n{khal_week}"
    }

    print(json.dumps(out), flush=True)
    time.sleep(1)
