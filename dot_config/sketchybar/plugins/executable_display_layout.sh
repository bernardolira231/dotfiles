#!/usr/bin/env bash

# Draws the bar only on external displays. The built-in display keeps the
# native macOS menu bar instead. Runs at startup and on display_change.
MAIN_WORKSPACES=(1 2 3 4 5)
SECONDARY_WORKSPACES=(A S F)
STATUS_ITEMS=(front_app network volume battery clock)

# Collects external displays into the global "external" array.
detect_external() {
  builtin_ids="$(osascript -l JavaScript -e '
    ObjC.import("AppKit");
    ObjC.bindFunction("CGDisplayIsBuiltin", ["unsigned int", ["unsigned int"]]);
    var screens = $.NSScreen.screens, ids = [];
    for (var i = 0; i < screens.count; i++) {
      var id = screens.objectAtIndex(i).deviceDescription.objectForKey("NSScreenNumber").js;
      if ($.CGDisplayIsBuiltin(id)) ids.push(id);
    }
    ids.join(",");
  ' 2>/dev/null)"

  external=()
  while read -r arrangement display_id; do
    [ -z "$arrangement" ] && continue
    case ",$builtin_ids," in
      *",$display_id,"*) continue ;;
    esac
    external+=("$arrangement")
  done < <(sketchybar --query displays | jq -r '.[] | "\(.["arrangement-id"]) \(.DirectDisplayID)"')
}

# Hides the native menu bar while SketchyBar is shown on an external display,
# and restores it ("In Full Screen Only") on the built-in display alone.
# Failures (e.g. revoked Automation permission) are appended to
# ~/Library/Logs/sketchybar-menubar.log.
# Skips the write when the value already matches: every write resizes the
# screen and fires display_change, which would re-run this script in a loop.
set_menu_bar_autohide() {
  local out current
  current="$(osascript -e 'tell application "System Events" to get autohide menu bar of dock preferences' 2>/dev/null)"
  [ "$current" = "$1" ] && return 0
  if ! out="$(osascript -e "tell application \"System Events\" to set autohide menu bar of dock preferences to $1" 2>&1)"; then
    echo "$(date '+%F %T') autohide=$1 failed: $out" >>"$HOME/Library/Logs/sketchybar-menubar.log"
  fi
}

# Display events can fire mid-transition (lid closing, monitors reconnecting)
# when no external display is reported yet. Re-check before hiding the bar.
detect_external
for _ in 1 2 3; do
  [ "${#external[@]}" -gt 0 ] && break
  sleep 1
  detect_external
done

# Last applied layout. Re-applying an unchanged layout (and its --update,
# which re-runs every item script) is skipped so events cannot feed a loop.
STATE_FILE="${TMPDIR:-/tmp}/sketchybar_display_layout.state"

# Returns success when the layout differs from the last applied one.
layout_changed() {
  [ "$(cat "$STATE_FILE" 2>/dev/null)" != "$1" ]
}

if [ "${#external[@]}" -eq 0 ]; then
  if layout_changed "hidden"; then
    sketchybar --bar hidden=on && echo "hidden" >"$STATE_FILE"
  fi
  set_menu_bar_autohide false
  exit 0
fi

external_ids="$(IFS=,; echo "${external[*]}")"
args=(--bar hidden=off display="$external_ids")

if [ "${#external[@]}" -ge 2 ]; then
  # Two or more external displays: one workspace group per display.
  main_display="${external[0]}"
  secondary_display="${external[1]}"
  status_display=active
  secondary_drawing=on
else
  # One external display: only the main workspaces; A/S/F are hidden.
  main_display="${external[0]}"
  secondary_display="${external[0]}"
  status_display="${external[0]}"
  secondary_drawing=off
fi

for ws in "${MAIN_WORKSPACES[@]}"; do
  args+=(--set "workspace.$ws" display="$main_display")
  [ "$ws" != 5 ] && args+=(--set "workspace_gap.$ws" display="$main_display")
done

for ws in "${SECONDARY_WORKSPACES[@]}"; do
  args+=(--set "workspace.$ws" display="$secondary_display" drawing="$secondary_drawing")
  [ "$ws" != F ] && args+=(--set "workspace_gap.$ws" display="$secondary_display" drawing="$secondary_drawing")
done

args+=(--set workspace.A padding_left=0)

for item in "${STATUS_ITEMS[@]}"; do
  args+=(--set "$item" display="$status_display")
done

layout_key="${args[*]}"
if layout_changed "$layout_key"; then
  # Record the layout only once applied, so a failed apply is retried.
  sketchybar "${args[@]}" --update && echo "$layout_key" >"$STATE_FILE"
fi
set_menu_bar_autohide true
