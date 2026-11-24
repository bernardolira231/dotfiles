#!/usr/bin/env bash

# Draws the bar only on external displays. The built-in display keeps the
# native macOS menu bar instead. Runs at startup and on display_change.
MAIN_WORKSPACES=(1 2 3 4 5)
SECONDARY_WORKSPACES=(A S F)
STATUS_ITEMS=(front_app network volume battery clock)

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

if [ "${#external[@]}" -eq 0 ]; then
  sketchybar --bar hidden=on
  exit 0
fi

external_ids="$(IFS=,; echo "${external[*]}")"
args=(--bar hidden=off display="$external_ids")

if [ "${#external[@]}" -ge 2 ]; then
  # Two or more external displays: one workspace group per display.
  main_display="${external[0]}"
  secondary_display="${external[1]}"
  status_display=active
  secondary_gap=0
else
  # One external display: every workspace on the same bar.
  main_display="${external[0]}"
  secondary_display="${external[0]}"
  status_display="${external[0]}"
  secondary_gap=10
fi

for ws in "${MAIN_WORKSPACES[@]}"; do
  args+=(--set "workspace.$ws" display="$main_display")
  [ "$ws" != 5 ] && args+=(--set "workspace_gap.$ws" display="$main_display")
done

for ws in "${SECONDARY_WORKSPACES[@]}"; do
  args+=(--set "workspace.$ws" display="$secondary_display")
  [ "$ws" != F ] && args+=(--set "workspace_gap.$ws" display="$secondary_display")
done

args+=(--set workspace.A padding_left="$secondary_gap")

for item in "${STATUS_ITEMS[@]}"; do
  args+=(--set "$item" display="$status_display")
done

sketchybar "${args[@]}"
