#!/bin/bash

source "$CONFIG_DIR/plugins/icon_map.sh"

APP_NAME="$INFO"
if [ -z "$APP_NAME" ]; then
  APP_NAME=$(osascript -e 'tell application "System Events" to get name of first application process whose frontmost is true' 2>/dev/null)
fi

ICON=$(icon_map "$APP_NAME")

sketchybar --set "$NAME" icon="$ICON" label="$APP_NAME"
