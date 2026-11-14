#!/usr/bin/env bash
# Bootstrap a new Mac from these dotfiles.
# Usage: bash "$(chezmoi source-path)/bootstrap.sh"
set -euo pipefail

SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "This bootstrap only supports macOS." >&2
  exit 1
fi

if ! command -v brew >/dev/null 2>&1; then
  echo "==> Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"

echo "==> Installing packages from Brewfile"
if ! brew bundle --file="$SOURCE_DIR/Brewfile"; then
  echo "WARNING: some Brewfile entries failed. Continuing; re-run bootstrap later to retry them." >&2
fi

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  echo "==> Installing Oh My Zsh"
  RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
  echo "==> Installing tmux plugin manager"
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

echo "==> Applying dotfiles"
chezmoi apply

cat <<'EOF'

Done. Manual steps:
  - Install gentle-ai and run its setup (skills, agents, CLAUDE.md, OpenCode config).
  - Install apps not in Homebrew: Karabiner-Elements, Jump Desktop Connect, Tailscale.
  - Log in to Claude Code, OpenCode, Pi, GitHub (gh auth login) and Tailscale.
  - In tmux press prefix + I to install plugins.
  - Open AeroSpace once: it starts SketchyBar and borders on launch.
EOF
