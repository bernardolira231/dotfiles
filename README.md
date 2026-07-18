# Dotfiles

Chezmoi-managed configuration for macOS and Omarchy. The Omarchy profile keeps
the existing Omarchy desktop stack and applies the Rose Pine application setup
for Neovim, OpenCode, Pi, Herdr, and Ghostty.

## Omarchy installation

1. Install Omarchy and `chezmoi` first. Do not replace Hyprland, Waybar, Ghostty,
   or other Omarchy-owned packages with parallel copies.
   Before applying, manually install Claude Code, OpenCode, Pi, Herdr, Gentle AI,
   Engram, and CodeGraph using their verified vendor or project instructions.
   Their installers are intentionally not guessed by this repository.
2. Clone and initialize without applying changes:

   ```sh
   chezmoi init bernardolira231/dotfiles
   chezmoi diff
   chezmoi apply --dry-run --verbose
   ```

   On Linux, choose the `omarchy` profile when prompted.
3. Back up any destination files shown by `chezmoi diff`, then apply:

   ```sh
   chezmoi apply
   ```

The post-apply setup script verifies Arch and Omarchy, installs only missing
packages from configured pacman repositories, links the local Herdr navigation
plugin, and recreates Claude Code, OpenCode, and Pi Herdr integrations. It never
changes the login shell or replaces Omarchy's Hyprland/Waybar configuration.

Authentication is intentionally not managed. After applying, authenticate
Claude Code, OpenCode, Pi, and any MCP services manually. Restart OpenCode after
apply so it reloads its global config, plugins, agents, commands, and skills.
