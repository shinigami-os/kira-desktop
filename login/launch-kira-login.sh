#!/bin/sh
# cage's client command (set from kira-greetd's config.toml). Starts the eww
# daemon against this config and opens the one login window, then blocks so
# cage has a process to supervise - if eww's own process exits, cage exits
# too and greetd retries the greeter.
cd "$(dirname "$0")" || exit 1

export GDK_BACKEND=wayland
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/greetd}"

eww kill 2>/dev/null
sleep 0.3
eww daemon >/dev/null 2>&1
sleep 0.5
eww open login

# eww daemon backgrounds itself; wait on it so this script (cage's child)
# stays alive for the duration of the greeter session
pid=$(pgrep -f "eww daemon" | head -n1)
if [ -n "$pid" ]; then
    while kill -0 "$pid" 2>/dev/null; do
        sleep 1
    done
else
    sleep infinity
fi
