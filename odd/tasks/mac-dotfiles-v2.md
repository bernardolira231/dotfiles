# mac-dotfiles-v2

Objective: rebuild the chezmoi dotfiles from scratch for macOS-to-macOS only, using the live Mac mini config as the source of truth, ready to install the new MacBook (~2026-11-28).
Branch: `feat/mac-only-v2` (archive tag `archive/v1-macos-omarchy`). Delivery: pending user decision before push (public repo). Checks: secret scan, `chezmoi diff` against the live Mac mini, `chezmoi apply --dry-run` in a scratch HOME.

## Specs

- S1: Start over, Mac only. User: "yo diria de borrar los dotfiles actuales y empezar de cero, ahora enfocado en que funcione de mac a mac". Accepted proposal (user: "va perfecto"): archive the old content instead of deleting it, use what works today on the Mac mini as the source of truth, and install the MacBook only from this repo.
- S2: No Omarchy/Linux support. User: "tengo la maquina con omarchy pero ya no la uso".
- S3: Keep tmux. User: "tmux dejalo aveces se usa". WezTerm is dropped (not installed).
- S4: Only personal configuration; no gentle-ai generated assets (skills, agents, commands, orchestrator prompts). User: "si dejemos configuraciones nada mas y yo instalo gentle-ai aparte".
- S5: The repo is PUBLIC. No credentials, tokens, auth files, histories, sessions or machine state may be committed.
- S6: Tools in scope (detected in use on the Mac mini): zsh + p10k, Ghostty, Herdr, tmux, AeroSpace, SketchyBar, borders, Karabiner, Neovim, lazygit, git, and personal settings for Claude Code, OpenCode and Pi.

## Tasks

| ID | Specs | Task | Route | Status | Commit |
|----|-------|------|-------|--------|--------|
| T1 | S1 | Archive tag + branch, clear old source tree, base metadata (ignores, README) | inline | done | 312b942 |
| T2 | S1,S6 | Shell: zshrc, zprofile, p10k | inline | done | 5df0c80 |
| T3 | S3,S6 | Terminal: Ghostty, Herdr, tmux | inline | done | 95ada3c |
| T4 | S6 | Desktop: AeroSpace, SketchyBar, borders, Karabiner | inline | done | ef93c20 |
| T5 | S6 | Dev: Neovim, lazygit, git | inline | done | 55808c5 |
| T6 | S4,S5 | AI personal settings (Risk: item 2, secrets in a public repo) | inline | done | 7d59eb5 |
| T7 | S1 | Brewfile + bootstrap for a new Mac (Risk: item 5, installers) | inline | done | 78db611 |
| T8 | S5 | Verify: secret scan, empty diff vs live, dry-run in scratch HOME | inline | done | (checks only) |
| T9 | S1 | Install the MacBook from the repo (blocked until it arrives) | inline | blocked | |

## Log

- L1 (2026-11-14) User: "yo diria de borrar los dotfiles actuales y empezar de cero, ahora enfocado en que funcione de mac a mac"
- L2 Decisions: Omarchy out (S2), tmux kept (S3), AI config only, without gentle-ai assets (S4).
- L3 Evidence: the old repo had drift vs live (sketchybarrc and plugins); README.md was being deployed to ~/README.md (it was not ignored). `git fetch` failed (no SSH key loaded in this session), so the branch is based on local master, which matched origin/master at last sync.
- L4 T6 scope: kept ~/.claude/settings.json, statusline.sh and ~/.pi/agent/settings.json. Excluded as gentle-ai generated: CLAUDE.md, output-styles, themes, skills, agents, commands, opencode.json (which embeds gentle-ai agent prompts; its model choices must be re-applied after gentle-ai setup). Herdr plugin dir vim-herdr-navigation is empty on the live Mac, so the Herdr plugin_action bindings need the plugin reinstalled (not versioned).
- L5 Brewfile is a dump of the live Mac minus wezterm (S3) and gentle-ai (S4). Unused-looking casks (amethyst, warp) were kept pending user review.
- L6 Verification (2026-11-14): `bash -n bootstrap.sh` OK; `chezmoi diff` vs live is empty; `chezmoi apply --destination <mktemp>` deployed 53 files (scratch removed); secret pattern scan over 59 tracked files found no matches, and no risky filenames. `brew bundle check` OK.
- L7 Next: the user decides on delivery (push the feature branch / replace master on the PUBLIC repo; the SSH key was not loaded in this session). T9 runs when the MacBook arrives.
