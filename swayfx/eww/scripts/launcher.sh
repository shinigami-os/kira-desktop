#!/bin/sh
# launcher.sh "<query>" -> eww update lch_results='[...]' (max 7 rows)
q="$1"
CACHE=/tmp/kira-apps.tsv

build_cache() {
  : > "$CACHE"
  for f in /usr/share/applications/*.desktop; do
    [ -r "$f" ] || continue
    n=$(grep -m1 '^Name=' "$f" | cut -d= -f2-)
    e=$(grep -m1 '^Exec=' "$f" | cut -d= -f2- | sed 's/ *%[fFuUdDnNickvm]//g')
    [ -n "$n" ] && [ -n "$e" ] && printf '%s\t%s\n' "$n" "$e" >> "$CACHE"
  done
}
[ -s "$CACHE" ] || build_cache

lower=$(printf '%s' "$q" | tr '[:upper:]' '[:lower:]')

# ---- easter eggs (exact/prefix matches) ----
egg() { printf '[{"g":"ki","n":"%s","d":"kira","exec":""}]' "$1"; }
case "$lower" in
  "rm -rf"*) eww update lch_results="$(egg 'no.')"; exit 0 ;;
  kira)      eww update lch_results="$(egg "i'm already awake.")"; exit 0 ;;
  hello|hi)  eww update lch_results="$(egg 'hey. need something?')"; exit 0 ;;
  sudo)      eww update lch_results="$(egg 'you own this machine. no need to ask.')"; exit 0 ;;
  meow)      eww update lch_results="$(egg '…this is a linux distribution.')"; exit 0 ;;
  love)      eww update lch_results="$(egg '…noted.')"; exit 0 ;;
  help)      eww update lch_results="$(egg 'press ? - or just breathe.')"; exit 0 ;;
  42)        eww update lch_results="$(egg 'obviously.')"; exit 0 ;;
esac

extra=""
case "$lower" in
  *power*|*off*|*exit*|*shutdown*|*reboot*|*quit*|*logout*|*bye*)
    extra='{"g":"pw","n":"power menu","d":"open","exec":"POWER"},' ;;
esac

rows=$(grep -i -- "$lower" "$CACHE" 2>/dev/null | head -7 | \
  awk -F'\t' '{
    g=tolower(substr($1,1,2));
    gsub(/"/,"",$1); gsub(/"/,"",$2);
    printf "%s{\"g\":\"%s\",\"n\":\"%s\",\"d\":\"run\",\"exec\":\"%s\"}", (NR>1?",":""), g, $1, $2
  }')

eww update lch_results="[${extra}${rows}]"
