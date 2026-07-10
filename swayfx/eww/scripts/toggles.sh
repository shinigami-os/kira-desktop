#!/bin/sh
S="/tmp/kira-toggles"
st() { [ -f "$S/$1" ] && echo true || echo false; }
printf '{"bt":%s,"dnd":%s,"night":%s}\n' "$(st bt)" "$(st dnd)" "$(st night)"
