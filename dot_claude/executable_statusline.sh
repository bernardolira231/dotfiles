#!/usr/bin/env bash
# Claude Code statusline. Reads the session JSON from stdin.

input=$(cat)

model=$(jq -r '.model.display_name' <<< "$input")
dir=$(basename "$(jq -r '.workspace.current_dir' <<< "$input")")
used=$(jq -r '.context_window.used_percentage // 0' <<< "$input")
pct=$(printf '%.0f' "$used")

# Context progress bar: 8 segments, "=" filled, "." empty.
segs=8
filled=$((pct * segs / 100))
[ "$filled" -gt "$segs" ] && filled=$segs
[ "$filled" -lt 0 ] && filled=0
empty=$((segs - filled))
bar=""
for ((i = 0; i < filled; i++)); do bar="${bar}="; done
for ((i = 0; i < empty; i++)); do bar="${bar}."; done

# Git segment (only inside a repo).
git_part=""
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  branch=$(git --no-optional-locks branch --show-current 2>/dev/null)
  dirty=""
  [ -n "$(git --no-optional-locks status --porcelain 2>/dev/null)" ] && dirty="*"
  stat=$(git --no-optional-locks diff --shortstat 2>/dev/null)
  ins=0
  del=0
  [[ $stat =~ ([0-9]+)\ insertion ]] && ins=${BASH_REMATCH[1]}
  [[ $stat =~ ([0-9]+)\ deletion ]] && del=${BASH_REMATCH[1]}
  git_part=$(printf '   \033[38;5;180m%s%s\033[0m   \033[38;5;108m+%s\033[0m \033[38;5;174m-%s\033[0m' \
    "$branch" "$dirty" "$ins" "$del")
fi

# Colors: model = warm/bold, folder = tan, ctx = dim.
printf '\033[1;38;5;173m🧔 %s\033[0m   \033[38;5;179m📁 %s\033[0m%s   \033[2mctx [%s] %s%%\033[0m' \
  "$model" "$dir" "$git_part" "$bar" "$pct"
