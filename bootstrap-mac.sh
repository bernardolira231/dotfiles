#!/bin/bash
# Bootstrap para Mac mini M4
# Ejecutar una sola vez después de aplicar dotfiles
# Uso: bash bootstrap-mac.sh

set -e

echo "==> Instalando Homebrew si no está..."
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "==> Instalando paquetes base..."
brew install \
  chezmoi \
  neovim \
  tmux \
  git \
  fzf \
  zoxide \
  atuin \
  carapace \
  eza \
  bat \
  lsd \
  ripgrep \
  fd \
  lazygit

echo "==> Instalando plugins de zsh..."
brew install \
  zsh-autosuggestions \
  zsh-syntax-highlighting \
  zsh-autocomplete \
  powerlevel10k

echo "==> Instalando oh-my-zsh si no está..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

echo "==> Instalando TPM (tmux plugin manager)..."
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

echo "==> Aplicando dotfiles con chezmoi..."
chezmoi apply

echo ""
echo "Listo. Abre una terminal nueva y ejecuta:"
echo "  tmux new && tmux source ~/.tmux.conf"
echo "  Dentro de tmux: Ctrl+a I  (para instalar plugins)"
