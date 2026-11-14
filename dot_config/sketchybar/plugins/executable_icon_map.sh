#!/bin/bash

icon_map() {
  case "$1" in
    "Ghostty"|"ghostty"|"iTerm2"|"iTerm"|"Terminal"|"WezTerm"|"Warp") echo ":terminal:" ;;
    "Arc") echo ":arc:" ;;
    "Safari") echo ":safari:" ;;
    "Google Chrome"|"Google Chrome Canary"|"Chromium") echo ":google_chrome:" ;;
    "Brave Browser") echo ":brave_browser:" ;;
    "Firefox"|"Firefox Developer Edition"|"Firefox Nightly") echo ":firefox:" ;;
    "Code"|"Code - Insiders"|"Visual Studio Code"|"VSCodium") echo ":code:" ;;
    "Cursor") echo ":default:" ;;
    "Windsurf") echo ":default:" ;;
    "Antigravity"|"Antigravity IDE") echo ":default:" ;;
    "Codex"|"ChatGPT") echo ":default:" ;;
    "Notion") echo ":notion:" ;;
    "Notion Calendar") echo ":calendar:" ;;
    "Postman"|"Postman Agent") echo ":default:" ;;
    "Docker"|"Docker Desktop") echo ":docker:" ;;
    "Tailscale") echo ":default:" ;;
    "AeroSpace"|"SketchyBar"|"Amethyst") echo ":gear:" ;;
    "Karabiner-Elements") echo ":keyboard_maestro:" ;;
    "BetterDisplay") echo ":desktop:" ;;
    "UTM"|"VMware Fusion"|"Parallels Desktop") echo ":parallels:" ;;
    "Numbers") echo ":numbers:" ;;
    "Microsoft Outlook") echo ":mail:" ;;
    "Telegram"|"Telegram Desktop") echo ":telegram:" ;;
    "WhatsApp") echo ":whats_app:" ;;
    "Raycast") echo ":raycast:" ;;
    "Xcode") echo ":xcode:" ;;
    "Microsoft Teams") echo ":microsoft_teams:" ;;
    "Slack") echo ":slack:" ;;
    "Discord"|"Discord Canary"|"Discord PTB") echo ":discord:" ;;
    "Finder") echo ":finder:" ;;
    "Spotify"|"Music") echo ":spotify:" ;;
    "Preview") echo ":pdf:" ;;
    *) echo ":default:" ;;
  esac
}
