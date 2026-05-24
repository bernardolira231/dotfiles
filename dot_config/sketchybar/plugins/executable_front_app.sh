#!/bin/bash

source "$CONFIG_DIR/plugins/icon_map.sh"

APP_NAME="$INFO"
if [ -z "$APP_NAME" ]; then
  APP_NAME=$(osascript -e 'tell application "System Events" to get name of first application process whose frontmost is true' 2>/dev/null)
fi

ICON=$(icon_map "$APP_NAME")

# Use sketchybar-app-font tokens (e.g. :terminal:).
sketchybar --set "$NAME" icon="$ICON" icon.font="sketchybar-app-font:Regular:17.0" label="$APP_NAME"
