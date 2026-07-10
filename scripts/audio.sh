#!/bin/sh
# Start the PipeWire stack in the correct order, under the session bus.
# Kill any stale instances first.
pkill -x pipewire 2>/dev/null
pkill -x wireplumber 2>/dev/null
pkill -x pipewire-pulse 2>/dev/null
sleep 0.3

# 1. core daemon
/usr/bin/pipewire &
# 2. wait for the socket to appear (max ~2s)
i=0
while [ ! -S "$XDG_RUNTIME_DIR/pipewire-0" ] && [ $i -lt 20 ]; do
    sleep 0.1
    i=$((i + 1))
done

# 3. session manager + pulse shim
/usr/bin/wireplumber &
/usr/bin/pipewire-pulse &
