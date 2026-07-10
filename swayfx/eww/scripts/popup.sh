#!/bin/sh
# popup.sh <name>|close-all  — single-open toggle across popups and modals
cd "$(dirname "$0")/.." || exit 1
name="$1"; [ -z "$name" ] && exit 0

POPUPS="calendar control notif music sysmon"
MODALS="launcher overview power keys"

win_of() {
  case "$1" in
    calendar|control|notif|music|sysmon) echo "popup-$1" ;;
    launcher|overview|power|keys)        echo "modal-$1" ;;
    *) echo "" ;;
  esac
}

close_all() {
  for w in $POPUPS; do eww close "popup-$w" 2>/dev/null; done
  for w in $MODALS; do eww close "modal-$w" 2>/dev/null; done
}

if [ "$name" = "close-all" ]; then close_all; exit 0; fi

win=$(win_of "$name"); [ -z "$win" ] && exit 0

if eww active-windows 2>/dev/null | grep -q "^$win"; then
  eww close "$win" 2>/dev/null
else
  close_all
  # refresh data feeding this popup just before opening
  case "$name" in
    calendar) eww update caljson="$(python3 scripts/cal.py)" 2>/dev/null ;;
    notif)    eww update notiflist="$(sh scripts/notifs.sh)" 2>/dev/null ;;
    control)  eww update toggles="$(sh scripts/toggles.sh)" 2>/dev/null ;;
    sysmon)   eww update bigspark="$(sh scripts/cpu_hist.sh)" procs="$(python3 scripts/procs.py)" 2>/dev/null ;;
    launcher) eww update lch_results="[]" query="" 2>/dev/null
              sh scripts/launcher.sh "" & ;;
  esac
  eww open "$win" 2>/dev/null
fi
