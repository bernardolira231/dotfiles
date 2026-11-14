# Dotfiles

Chezmoi-managed configuration for macOS (Mac to Mac). The previous macOS + Omarchy
version is archived at the `archive/v1-macos-omarchy` tag.

## What is managed

- Shell: zsh, Powerlevel10k
- Terminal: Ghostty, Herdr, tmux
- Desktop: AeroSpace (also launches borders), SketchyBar, Karabiner-Elements
- Dev: Neovim (LazyVim), lazygit, git
- AI: personal Claude Code and Pi settings only

gentle-ai assets (skills, agents, commands, CLAUDE.md, OpenCode config) are not
versioned here: install gentle-ai separately and let it generate them.

## New Mac

```sh
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
brew install chezmoi
chezmoi init bernardolira231/dotfiles
chezmoi diff
bash "$(chezmoi source-path)/bootstrap.sh"
```

`bootstrap.sh` installs Homebrew, the `Brewfile`, Oh My Zsh and TPM, then runs
`chezmoi apply` and prints the remaining manual steps.

## Rules

This repository is public. Never add credentials, tokens, auth files, histories,
sessions or machine state. Update the Brewfile with
`brew bundle dump --file=Brewfile --force --no-vscode`.
