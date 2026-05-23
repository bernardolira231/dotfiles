#!/bin/bash

DEFAULT_IF=$(route get default 2>/dev/null | awk '/interface:/{print $2}')
WIFI_DEVICE=$(networksetup -listallhardwareports 2>/dev/null | awk '/Wi-Fi|AirPort/{getline; print $2; exit}')
ETH_DEVICE=$(networksetup -listallhardwareports 2>/dev/null | awk '/Ethernet/{getline; print $2; exit}')

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

sketchybar --set "$NAME" icon="$ICON" label="$LABEL"
