#!/bin/bash
# Bootstrap para ThinkPad X13 G1 - Arch Linux + Omarchy
# Ejecutar una sola vez después de instalar Arch y Omarchy
# Uso: bash bootstrap-arch.sh

set -e

echo "==> Actualizando sistema..."
sudo pacman -Syu --noconfirm

echo "==> Instalando paquetes base..."
sudo pacman -S --noconfirm \
  neovim \
  tmux \
  git \
  fzf \
  zoxide \
  atuin \
  ripgrep \
  fd \
  lazygit \
  zsh \
  curl \
  wget \
  base-devel

echo "==> Instalando yay (AUR helper) si no está..."
if ! command -v yay &>/dev/null; then
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  (cd /tmp/yay && makepkg -si --noconfirm)
  rm -rf /tmp/yay
fi

echo "==> Instalando paquetes AUR..."
yay -S --noconfirm \
  chezmoi \
  eza \
  bat \
  lsd \
  carapace-bin \
  zsh-autosuggestions \
  zsh-syntax-highlighting \
  zsh-autocomplete \
  zsh-theme-powerlevel10k

echo "==> Instalando oh-my-zsh si no está..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

echo "==> Cambiando shell a zsh..."
if [ "$SHELL" != "$(which zsh)" ]; then
  chsh -s "$(which zsh)"
fi

echo "==> Instalando TPM (tmux plugin manager)..."
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

echo "==> Aplicando dotfiles con chezmoi..."
chezmoi init --apply https://github.com/bernardolira231/dotfiles.git

echo ""
echo "Listo. Abre una terminal nueva y ejecuta:"
echo "  tmux new && tmux source ~/.tmux.conf"
echo "  Dentro de tmux: Ctrl+a I  (para instalar plugins)"
echo ""
echo "Para nvim: abre nvim y espera que LazyVim instale plugins."
