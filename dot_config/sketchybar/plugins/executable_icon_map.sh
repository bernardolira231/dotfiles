#!/bin/bash

icon_map() {
  case "$1" in
    "Ghostty") echo "" ;;
    "iTerm2"|"iTerm") echo "" ;;
    "Terminal") echo "" ;;
    "WezTerm") echo "" ;;
    "Warp") echo "" ;;
    "Brave Browser") echo "󰖟" ;;
    "Arc") echo "󰇩" ;;
    "Safari") echo "󰀹" ;;
    "Google Chrome") echo "" ;;
    "Firefox") echo "󰈹" ;;
    "Code"|"Visual Studio Code") echo "󰨞" ;;
    "Cursor") echo "󰚩" ;;
    "Windsurf") echo "󰚩" ;;
    "Antigravity"|"Antigravity IDE") echo "󰚩" ;;
    "Codex") echo "󰚩" ;;
    "ChatGPT") echo "󰚩" ;;
    "Notion") echo "󰎚" ;;
    "Postman") echo "󰛮" ;;
    "Docker") echo "󰡨" ;;
    "Tailscale") echo "󰒃" ;;
    "Microsoft Teams") echo "󰊻" ;;
    "Slack") echo "󰒱" ;;
    "Discord") echo "󰙯" ;;
    "Telegram") echo "󰈈" ;;
    "WhatsApp") echo "󰖣" ;;
    "Raycast") echo "󰕧" ;;
    "Finder") echo "󰀶" ;;
    "Spotify") echo "󰓇" ;;
    "Music") echo "󰓇" ;;
    "Numbers") echo "󰈙" ;;
    "Preview") echo "󰋩" ;;
    *) echo "󰣆" ;;
  esac
}
