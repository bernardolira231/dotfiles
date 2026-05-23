#!/bin/bash

icon_map() {
  case "$1" in
    "Ghostty") echo "" ;;
    "Brave Browser") echo "󰖟" ;;
    "Arc") echo "󰇩" ;;
    "Code"|"Visual Studio Code") echo "󰨞" ;;
    "Cursor") echo "󰚩" ;;
    "Microsoft Teams") echo "󰊻" ;;
    "Slack") echo "󰒱" ;;
    "Discord") echo "󰙯" ;;
    "ChatGPT") echo "󰚩" ;;
    "Safari") echo "󰀹" ;;
    "Finder") echo "󰀶" ;;
    "Spotify") echo "󰓇" ;;
    *) echo "󰣆" ;;
  esac
}
