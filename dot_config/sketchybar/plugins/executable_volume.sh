#!/bin/sh

# Prefer event data, then read the current output volume for manual refreshes.

VOLUME="$INFO"
if [ -z "$VOLUME" ]; then
  VOLUME=$(osascript -e 'output volume of (get volume settings)' 2>/dev/null)
fi

if [ -n "$VOLUME" ]; then
  case "$VOLUME" in
    [6-9][0-9]|100) ICON="󰕾"
    ;;
    [3-5][0-9]) ICON="󰖀"
    ;;
    [1-9]|[1-2][0-9]) ICON="󰕿"
    ;;
    *) ICON="󰖁"
  esac

  sketchybar --set "$NAME" icon="$ICON" label="$VOLUME%"
  if [ "$NAME" = "volume" ]; then
    sketchybar --set volume.status icon="$ICON" label="$VOLUME%"
  fi
fi
