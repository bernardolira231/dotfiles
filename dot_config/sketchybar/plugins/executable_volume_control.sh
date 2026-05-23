#!/bin/bash

CURRENT=$(osascript -e 'output volume of (get volume settings)' 2>/dev/null)

if [ "$1" = "up" ]; then
  NEXT=$((CURRENT + 5))
elif [ "$1" = "down" ]; then
  NEXT=$((CURRENT - 5))
else
  DELTA=${SCROLL_DELTA:-0}
  if [ "${DELTA%%.*}" -gt 0 ] 2>/dev/null; then
    NEXT=$((CURRENT + 5))
  else
    NEXT=$((CURRENT - 5))
  fi
fi

if [ "$NEXT" -gt 100 ]; then NEXT=100; fi
if [ "$NEXT" -lt 0 ]; then NEXT=0; fi

osascript -e "set volume output volume $NEXT" >/dev/null 2>&1
sketchybar --trigger volume_change INFO="$NEXT"
sketchybar --trigger volume_refresh INFO="$NEXT"
