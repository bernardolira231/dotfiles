#!/bin/bash

DEFAULT_IF=$(route get default 2>/dev/null | awk '/interface:/{print $2}')
WIFI_DEVICE=$(networksetup -listallhardwareports 2>/dev/null | awk '/Wi-Fi|AirPort/{getline; print $2; exit}')
ETH_DEVICE=$(networksetup -listallhardwareports 2>/dev/null | awk '/Ethernet/{getline; print $2; exit}')
IP=$(ipconfig getifaddr "$DEFAULT_IF" 2>/dev/null)

ICON="󰖩"
LABEL="Offline"

if [ -n "$DEFAULT_IF" ] && [ "$DEFAULT_IF" = "$WIFI_DEVICE" ]; then
  SSID=$(networksetup -getairportnetwork "$WIFI_DEVICE" 2>/dev/null | sed 's/^Current Wi-Fi Network: //')
  ICON="󰖩"
  LABEL=${SSID:-Wi-Fi}
elif [ -n "$DEFAULT_IF" ] && [ "$DEFAULT_IF" = "$ETH_DEVICE" ]; then
  ICON="󰈀"
  LABEL="Ethernet"
fi

if [ ${#LABEL} -gt 12 ]; then
  LABEL="${LABEL:0:12}..."
fi

sketchybar --set "$NAME" icon="$ICON" label="$LABEL"

if [ "$NAME" = "network" ] || [ "$SENDER" = "network_refresh" ]; then
  STATUS_LABEL="$LABEL"
  if [ -n "$DEFAULT_IF" ]; then
    DETAIL_LABEL="$DEFAULT_IF ${IP:-no-ip}"
  else
    DETAIL_LABEL="offline"
  fi

  sketchybar --set network.status icon="$ICON" label="$STATUS_LABEL"
  sketchybar --set network.ip icon=󰩠 label="$DETAIL_LABEL"
fi
