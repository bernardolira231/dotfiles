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

# Cask fonts can arrive quarantined, and macOS then hides them from apps
# (SketchyBar shows "?" boxes and ":app:" text instead of icons).
if [[ -d "$HOME/Library/Fonts" ]]; then
  echo "==> Clearing quarantine from user fonts"
  xattr -dr com.apple.quarantine "$HOME/Library/Fonts" 2>/dev/null || true
  killall fontd 2>/dev/null || true
fi

if [[ ! -x "$HOME/.local/bin/claude" ]]; then
  echo "==> Installing Claude Code"
  curl -fsSL https://claude.ai/install.sh | bash || echo "WARNING: Claude Code install failed." >&2
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

echo "==> Installing tmux plugins"
"$HOME/.tmux/plugins/tpm/bin/install_plugins" || echo "WARNING: tmux plugin install failed; press prefix + I inside tmux." >&2

if command -v herdr >/dev/null 2>&1 && ! herdr plugin list 2>/dev/null | grep -q 'vim-herdr-navigation'; then
  echo "==> Installing herdr navigation plugin"
  herdr plugin install paulbkim-dev/vim-herdr-navigation --yes || echo "WARNING: herdr plugin install failed." >&2
fi

cat <<'EOF'

Done. Manual steps:
  - Install gentle-ai and run its setup (skills, agents, CLAUDE.md, OpenCode config).
  - Install apps not in Homebrew: Karabiner-Elements, Jump Desktop Connect, Tailscale.
  - Log in to Claude Code, OpenCode, Pi, GitHub (gh auth login) and Tailscale.
  - Open AeroSpace once: it starts SketchyBar and borders on launch.
EOF
