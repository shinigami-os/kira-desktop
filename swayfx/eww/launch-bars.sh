#!/bin/sh
# Start the eww daemon and open all 5 bar islands. Called by sway (exec_always).
cd "$(dirname "$0")" || exit 1

# Force GTK to use the Wayland backend. Without this, eww's daemon can hit
# "Failed to initialize GTK" when the environment is ambiguous.
export GDK_BACKEND=wayland
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"

eww kill 2>/dev/null
sleep 0.3
eww daemon >/dev/null 2>&1
sleep 0.5
sh scripts/cpu_hist.sh >/dev/null 2>&1
eww open-many bar-ws bar-media bar-clock bar-vitals bar-notif voice keyshint

# personality daemons (kill stale instances first)
pkill -f "scripts/ghost.sh" 2>/dev/null
rm -f /tmp/kira-ghost.pid
sh scripts/ghost.sh &
