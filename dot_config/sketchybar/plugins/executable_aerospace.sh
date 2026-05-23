#!/bin/bash

WORKSPACE="$1"
FOCUSED_WORKSPACE="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused 2>/dev/null)}"

if [ "$WORKSPACE" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set "$NAME" \
    icon.color=0xff06080f \
    background.color=0xffe0c15a \
    background.border_width=0
else
  sketchybar --set "$NAME" \
    icon.color=0xfff3f6f9 \
    background.color=0x40263356 \
    background.border_width=0
fi
