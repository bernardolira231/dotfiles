#!/usr/bin/env bash

source "$(dirname "$0")/../colors.sh"
MAIN_WORKSPACES=(1 2 3 4 5)
SECONDARY_WORKSPACES=(A S F)
WORKSPACES=("${MAIN_WORKSPACES[@]}" "${SECONDARY_WORKSPACES[@]}")

VISIBLE_WORKSPACES=()
while IFS= read -r workspace; do
  [ -n "$workspace" ] && VISIBLE_WORKSPACES+=("$workspace")
done < <(aerospace list-workspaces --monitor all --visible 2>/dev/null)

[ "${#VISIBLE_WORKSPACES[@]}" -eq 0 ] && exit 0

is_visible() {
  local workspace="$1"
  local visible_workspace

  for visible_workspace in "${VISIBLE_WORKSPACES[@]}"; do
    [ "$workspace" = "$visible_workspace" ] && return 0
  done

  return 1
}

refresh_workspace() {
  local workspace="$1"

  if is_visible "$workspace"; then
    sketchybar --set "workspace.$workspace" \
      icon.color=$RP_ROSE \
      label="" \
      label.drawing=off \
      background.drawing=on \
      background.color=$RP_SURFACE_SOFT \
      background.border_color=$RP_ROSE \
      background.border_width=2
  else
    sketchybar --set "workspace.$workspace" \
      icon.color=$RP_SUBTLE \
      label="" \
      label.drawing=off \
      background.drawing=on \
      background.color=$RP_SURFACE_SOFT \
      background.border_color=$RP_HIGHLIGHT_MEDIUM \
      background.border_width=1
  fi
}

for workspace in "${WORKSPACES[@]}"; do
  refresh_workspace "$workspace"
done
