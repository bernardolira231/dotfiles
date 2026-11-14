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
| T1 | S1 | Archive tag + branch, clear old source tree, base metadata (ignores, README) | inline | in progress | |
| T2 | S1,S6 | Shell: zshrc, zprofile, p10k | inline | todo | |
| T3 | S3,S6 | Terminal: Ghostty, Herdr, tmux | inline | todo | |
| T4 | S6 | Desktop: AeroSpace, SketchyBar, borders, Karabiner | inline | todo | |
| T5 | S6 | Dev: Neovim, lazygit, git | inline | todo | |
| T6 | S4,S5 | AI personal settings (Risk: item 2, secrets in a public repo) | inline | todo | |
| T7 | S1 | Brewfile + bootstrap for a new Mac (Risk: item 5, installers) | inline | todo | |
| T8 | S5 | Verify: secret scan, empty diff vs live, dry-run in scratch HOME | inline | todo | |
| T9 | S1 | Install the MacBook from the repo (blocked until it arrives) | inline | blocked | |

## Log

- L1 (2026-11-14) User: "yo diria de borrar los dotfiles actuales y empezar de cero, ahora enfocado en que funcione de mac a mac"
- L2 Decisions: Omarchy out (S2), tmux kept (S3), AI config only, without gentle-ai assets (S4).
- L3 Evidence: the old repo had drift vs live (sketchybarrc and plugins); README.md was being deployed to ~/README.md (it was not ignored). `git fetch` failed (no SSH key loaded in this session), so the branch is based on local master, which matched origin/master at last sync.
