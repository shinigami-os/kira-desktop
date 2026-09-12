#!/bin/sh
# enumerates installed wayland sessions for the login screen's session dropdown,
# rather than hardcoding sway/hyprland/tty like the design prototype does -
# whatever DE packages are actually installed on this build is what shows up
out="[]"

for f in /usr/share/wayland-sessions/*.desktop /usr/share/xsessions/*.desktop; do
    [ -f "$f" ] || continue
    name=$(sed -n 's/^Name=//p' "$f" | head -n1)
    exec_line=$(sed -n 's/^Exec=//p' "$f" | head -n1 | sed 's/ %[a-zA-Z]//g')
    [ -n "$name" ] && [ -n "$exec_line" ] || continue
    cmd_json=$(printf '%s\n' "$exec_line" | jq -R 'split(" ") | map(select(length > 0))')
    out=$(printf '%s\n' "$out" | jq --arg name "$name" --argjson cmd "$cmd_json" \
        '. + [{"name":$name,"cmd":$cmd,"type":"wayland"}]')
done

# always-present fallback: a plain login shell on the VT, no compositor
out=$(printf '%s\n' "$out" | jq '. + [{"name":"tty","cmd":["__TTY__"],"type":"console"}]')

# -c is required, not cosmetic: deflisten treats each line of stdout as one
# complete value, and jq's default pretty-printer spreads a single array
# across many lines, which eww then tries to parse line-by-line as JSON
# fragments ("Failed to turn `]` into a value of type json-value" etc.)
printf '%s\n' "$out" | jq -c .
