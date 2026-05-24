#!/usr/bin/env bash

# Always show a BT indicator. If an audio device is connected, highlight it.

ACCENT=0xffcba6f7
MUTED=0xff8a8fa3

connected_audio=0

bt_json="$(system_profiler SPBluetoothDataType -json -detailLevel basic 2>/dev/null)"

if printf '%s' "$bt_json" \
  | jq -r '.SPBluetoothDataType[0].device_connected[]? | to_entries[] | "\(.key)\t\(.value.device_minorType // "")\t\(.value.device_minorClassOfDevice_string // "")"' 2>/dev/null \
  | grep -Eqi 'airpods|headphone|headset|audio'; then
  connected_audio=1
fi

if [ "$connected_audio" -eq 1 ]; then
  sketchybar --set "$NAME" icon.color=$ACCENT
else
  sketchybar --set "$NAME" icon.color=$MUTED
fi
