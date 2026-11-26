#!/usr/bin/env bash
# macOS preferences that differ from the factory defaults.
# chezmoi re-runs this script whenever its contents change.
# The menu bar auto-hide (_HIHideMenuBar) is intentionally not set here:
# SketchyBar's display_layout.sh toggles it per connected display.
set -euo pipefail

[[ "$(uname -s)" == "Darwin" ]] || exit 0

echo "==> Applying macOS preferences"

# System
defaults write -g AppleInterfaceStyle -string Dark
defaults write -g AppleShowAllExtensions -bool true

# Keyboard: fn is a Vim-arrow layer in Karabiner (fn + hjkl); stop it from
# opening the emoji picker.
defaults write com.apple.HIToolbox AppleFnUsageType -int 0

# Trackpad: tap to click, fastest pointer speed
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults -currentHost write -g com.apple.mouse.tapBehavior -int 1
defaults write -g com.apple.trackpad.scaling -float 3

# Dock
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock minimize-to-application -bool true

# Finder
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder NewWindowTarget -string PfHm

# Window tiling without gaps
defaults write com.apple.WindowManager EnableTiledWindowMargins -bool false

killall Dock Finder 2>/dev/null || true
