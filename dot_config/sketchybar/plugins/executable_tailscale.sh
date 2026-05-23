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
    ;;
  Starting)
    ICON="󰔛"
    LABEL="Starting"
    STATE_LABEL="Starting"
    ;;
  Stopped)
    ICON="󰢺"
    LABEL="Stopped"
    STATE_LABEL="Stopped"
    ;;
  *)
    ICON="󰢺"
    LABEL="$BACKEND"
    STATE_LABEL="$BACKEND"
    ;;
esac

if [ ${#TAILNET} -gt 16 ]; then
  TAILNET="${TAILNET:0:16}..."
fi

sketchybar --set tailscale icon="$ICON" label="$LABEL"
sketchybar --set tailscale.state icon="$ICON" label="$STATE_LABEL"
sketchybar --set tailscale.tailnet icon="󰇧" label="$TAILNET"
sketchybar --set tailscale.ip icon="󰩟" label="$IP"
