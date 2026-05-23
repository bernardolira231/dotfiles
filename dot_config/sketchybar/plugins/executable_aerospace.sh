#!/bin/bash

source "$CONFIG_DIR/plugins/icon_map.sh"

WORKSPACE="$1"
FOCUSED_WORKSPACE="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused 2>/dev/null)}"

apps=$(aerospace list-windows --workspace "$WORKSPACE" --format '%{app-name}' 2>/dev/null | awk '!seen[$0]++')

icons=""
if [ -n "$apps" ]; then
  while IFS= read -r app; do
    [ -z "$app" ] && continue
    icons="$icons $(icon_map "$app")"
  done <<EOF
$apps
EOF
fi

icons=$(printf '%s' "$icons" | xargs)

if [ -z "$icons" ]; then
  icons="-"
fi

if [ "$WORKSPACE" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set "$NAME" \
    icon.color=0xff06080f \
    label.color=0xff06080f \
    label="$icons" \
    background.color=0xffe0c15a
else
  sketchybar --set "$NAME" \
    icon.color=0xfff3f6f9 \
    label.color=0xfff3f6f9 \
    label="$icons" \
    background.color=0x40263356
fi
