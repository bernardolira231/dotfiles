#!/bin/bash

VOLUME="$INFO"
if [ -z "$VOLUME" ]; then
  VOLUME=$(osascript -e 'output volume of (get volume settings)' 2>/dev/null)
fi

case "$VOLUME" in
  [6-9][0-9]|100) ICON="󰕾" ;;
  [3-5][0-9]) ICON="󰖀" ;;
  [1-9]|[1-2][0-9]) ICON="󰕿" ;;
  *) ICON="󰖁" ;;
esac

sketchybar --set "$NAME" icon="$ICON" label="${VOLUME}%"

if [ "$NAME" = "volume" ] || [ "$SENDER" = "volume_refresh" ] || [ "$SENDER" = "volume_change" ]; then
  sketchybar --set volume.status icon="$ICON" label="Volume ${VOLUME}%"
fi
