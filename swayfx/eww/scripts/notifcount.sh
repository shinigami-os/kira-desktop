#!/bin/sh
# Count current mako notifications; fall back to 0.
c=$(makoctl list 2>/dev/null | jq '.data[0] | length' 2>/dev/null)
[ -z "$c" ] || [ "$c" = "null" ] && c=0
echo "$c"
