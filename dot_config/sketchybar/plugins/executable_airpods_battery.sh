#!/usr/bin/env bash

# Displays AirPods battery: left case right.
# Note: case battery is only reported while pods are in the case.

bt_json="$(system_profiler SPBluetoothDataType -json -detailLevel basic 2>/dev/null)"

has_airpods="$(printf '%s' "$bt_json" \
  | jq -r '.SPBluetoothDataType[0].device_connected[]? | to_entries[] | "\(.key)\t\(.value.device_minorType // "")"' 2>/dev/null \
  | grep -Eqi 'airpods' && echo yes || true)"

if [ -z "$has_airpods" ]; then
  sketchybar --set "$NAME" drawing=off
  exit 0
fi

sketchybar --set "$NAME" drawing=on

LEFT="$(defaults read /Library/Preferences/com.apple.Bluetooth BatteryPercentLeft 2>/dev/null || echo 0)"
RIGHT="$(defaults read /Library/Preferences/com.apple.Bluetooth BatteryPercentRight 2>/dev/null || echo 0)"
CASE="$(defaults read /Library/Preferences/com.apple.Bluetooth BatteryPercentCase 2>/dev/null || echo 0)"

if [ "$LEFT" = "0" ]; then LEFT="-"; fi
if [ "$RIGHT" = "0" ]; then RIGHT="-"; fi
if [ "$CASE" = "0" ]; then CASE="-"; fi

sketchybar --set "$NAME" label="$LEFT $CASE $RIGHT"
