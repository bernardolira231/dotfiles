#!/bin/bash

TAILSCALE_BIN="/usr/local/bin/tailscale"
if [ ! -x "$TAILSCALE_BIN" ]; then
  TAILSCALE_BIN=$(command -v tailscale 2>/dev/null)
fi

[ -z "$TAILSCALE_BIN" ] && exit 1

case "$1" in
  up)
    "$TAILSCALE_BIN" up >/dev/null 2>&1
    ;;
  down)
    "$TAILSCALE_BIN" down >/dev/null 2>&1
    ;;
esac

sketchybar --trigger tailscale_refresh
