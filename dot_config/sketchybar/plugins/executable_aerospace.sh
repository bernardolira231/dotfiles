#!/bin/bash

source "$CONFIG_DIR/plugins/icon_map.sh"

# Keep colors in sync with sketchybarrc (avoid sourcing it here).
ACCENT=0xffe0c15a
MUTED=0xff8a8fa3
BAR_DARK=0xff06080f

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
  icons=""
fi

if [ "$WORKSPACE" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set "$NAME" \
    icon.color=$BAR_DARK \
    label.color=$BAR_DARK \
    label="$icons" \
    background.drawing=on \
    background.color=$ACCENT
else
  if [ -z "$icons" ]; then
    sketchybar --set "$NAME" \
      icon.color=$MUTED \
      label.color=$MUTED \
      label="" \
      background.drawing=off
  else
    sketchybar --set "$NAME" \
      icon.color=$ACCENT \
      label.color=$ACCENT \
      label="$icons" \
      background.drawing=off
  fi
fi
