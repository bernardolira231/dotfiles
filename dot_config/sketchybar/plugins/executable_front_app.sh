#!/bin/sh

APP_NAME="$INFO"
if [ -z "$APP_NAME" ]; then
  APP_NAME=$(aerospace list-windows --focused --format '%{app-name}' 2>/dev/null)
fi

if [ -z "$APP_NAME" ]; then
  FRONT_ASN=$(lsappinfo front 2>/dev/null)
  if [ -n "$FRONT_ASN" ]; then
    APP_NAME=$(lsappinfo info -only name "$FRONT_ASN" 2>/dev/null \
      | sed -n 's/^"LSDisplayName"="\(.*\)"$/\1/p')
  fi
fi

if [ -z "$APP_NAME" ]; then
  sketchybar --set "${NAME:-front_app}" icon="" label=""
  exit 0
fi

. "$CONFIG_DIR/plugins/icon_map.sh"
APP_ICON=$(icon_map "$APP_NAME")

sketchybar --set "${NAME:-front_app}" icon="$APP_ICON" label="$APP_NAME"
