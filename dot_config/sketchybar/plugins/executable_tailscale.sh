#!/bin/bash

TAILSCALE_BIN="/usr/local/bin/tailscale"
if [ ! -x "$TAILSCALE_BIN" ]; then
  TAILSCALE_BIN=$(command -v tailscale 2>/dev/null)
fi

STATUS=$($TAILSCALE_BIN status --json 2>/dev/null)

if [ -z "$STATUS" ] || [ -z "$TAILSCALE_BIN" ]; then
  sketchybar --set tailscale icon="󰢹" label="Unavailable"
  sketchybar --set tailscale.state icon="󰢹" label="Unavailable"
  sketchybar --set tailscale.tailnet icon="󰇧" label="-"
  sketchybar --set tailscale.ip icon="󰩟" label="-"
  exit 0
fi

BACKEND=$(printf '%s' "$STATUS" | jq -r '.BackendState // "Unknown"')
TAILNET=$(printf '%s' "$STATUS" | jq -r '.CurrentTailnet.Name // "-"')
IP=$(printf '%s' "$STATUS" | jq -r '.TailscaleIPs[0] // "-"')

case "$BACKEND" in
  Running)
    ICON="󰢹"
    LABEL="Tailscale"
    STATE_LABEL="Connected"
    COLOR="0xffb7cc85"
    ;;
  Starting)
    ICON="󰔛"
    LABEL="Starting"
    STATE_LABEL="Starting"
    COLOR="0xffe0c15a"
    ;;
  Stopped)
    ICON="󰢺"
    LABEL="Stopped"
    STATE_LABEL="Stopped"
    COLOR="0xff8a8fa3"
    ;;
  *)
    ICON="󰢺"
    LABEL="$BACKEND"
    STATE_LABEL="$BACKEND"
    COLOR="0xffde8fa8"
    ;;
esac

if [ ${#TAILNET} -gt 16 ]; then
  TAILNET="${TAILNET:0:16}..."
fi

sketchybar --set tailscale icon="$ICON" label="$LABEL" icon.color="$COLOR"
sketchybar --set tailscale.state icon="$ICON" label="$STATE_LABEL" icon.color="$COLOR"
sketchybar --set tailscale.tailnet icon="󰇧" label="$TAILNET"
sketchybar --set tailscale.ip icon="󰩟" label="$IP"

if [ "$BACKEND" = "Running" ]; then
  sketchybar --set tailscale.connect label.color=0xff8a8fa3 icon.color=0xff8a8fa3
  sketchybar --set tailscale.disconnect label.color=0xffde8fa8 icon.color=0xffde8fa8
else
  sketchybar --set tailscale.connect label.color=0xffb7cc85 icon.color=0xffb7cc85
  sketchybar --set tailscale.disconnect label.color=0xff8a8fa3 icon.color=0xff8a8fa3
fi
