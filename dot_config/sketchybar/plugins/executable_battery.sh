#!/usr/bin/env bash

# Shows the internal battery level. pmset output looks like:
#   -InternalBattery-0 (id=...)	30%; discharging; (no estimate) present: true
BATT_INFO="$(pmset -g batt)"
PERCENTAGE="$(printf '%s\n' "$BATT_INFO" | grep -Eo '[0-9]+%' | head -1 | tr -d '%')"

if [ -z "$PERCENTAGE" ]; then
  sketchybar --set "$NAME" drawing=off
  exit 0
fi

case "$PERCENTAGE" in
  100 | 9[0-9]) ICON="󰁹" ;;
  [7-8][0-9]) ICON="󰂁" ;;
  [5-6][0-9]) ICON="󰁿" ;;
  [3-4][0-9]) ICON="󰁽" ;;
  [1-2][0-9]) ICON="󰁻" ;;
  *) ICON="󰂎" ;;
esac

if printf '%s\n' "$BATT_INFO" | grep -q "AC Power"; then
  ICON="󰂄"
fi

sketchybar --set "$NAME" drawing=on icon="$ICON" label="${PERCENTAGE}%"
