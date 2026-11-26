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
set_menu_bar_autohide() {
  osascript -e "tell application \"System Events\" to set autohide menu bar of dock preferences to $1" >/dev/null 2>&1
}

# Display events can fire mid-transition (lid closing, monitors reconnecting)
# when no external display is reported yet. Re-check before hiding the bar.
detect_external
for _ in 1 2 3; do
  [ "${#external[@]}" -gt 0 ] && break
  sleep 1
  detect_external
done

if [ "${#external[@]}" -eq 0 ]; then
  sketchybar --bar hidden=on
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
set_menu_bar_autohide true
