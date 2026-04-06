# Nix Configuration (NixOS & Home Manager)

This repository contains a Nix Flake configuration for managing personal dotfiles and user environments. **All hosts (ThinkPad and Dell Desktop) have transitioned to Arch Linux (CachyOS). NixOS is no longer used, and this repository is strictly for Home Manager configuration.**

## Project Overview

- **Main Technologies**: Nix Flakes, Home Manager, Arch Linux (CachyOS).
- **Architecture**: Modularized Home Manager configuration.
  - `hosts/`: Machine-specific entry points (ThinkPad/Dell) using `home.nix`.
  - `modules/home-manager/`: Modularized user configurations.
  - `modules/nixos/`: **Legacy - Do not use.**

## Policy & Conventions

- **Home Manager Only**: All changes must be scoped to Home Manager. Do not attempt to modify NixOS system configurations.
- **No Package Management**: Do not add system or user packages via Nix in this repository. Package management is handled separately (e.g., via Arch/Paru). This repo is for **configuration only**.
- **Formatting**: All `.nix` files must be formatted using `alejandra`.
- **Linting**: Static analysis via `statix` and `deadnix`.

## Key Commands

### Applying Configuration
To apply the Home Manager configuration for a specific host:
```bash
# General (uses hostname)
home-manager switch --flake .

# Specific host (e.g., dell-desk)
home-manager switch --flake .#dell-desk
```

### Maintenance
- **Update Dependencies**: `nix flake update`
- **Format Code**: `nix fmt` (uses `alejandra`)
- **Lint/Check**: `nix flake check` (uses `statix`, `deadnix`, and `pre-commit-hooks`)

### Development Environment
Entering the development shell provides `nix-ld` support and helper scripts:
```bash
nix develop
```
- Includes a `rebuild` helper script for NixOS.
- Sets up `NIX_LD_LIBRARY_PATH` for running unpatched binaries.

## Troubleshooting

### "Git tree is dirty" Warning
When using Nix Flakes, you may see a warning: `warning: Git tree '/path/to/repo' is dirty`. This happens because there are uncommitted changes or untracked files.

**Solutions:**
- **Temporary suppression**: Append `--no-warn-dirty` to your command:
  ```bash
  home-manager switch --flake .#dell-desk --no-warn-dirty
  ```
- **Staging changes**: New files *must* be added to the Git index for Nix to see them:
  ```bash
  git add .
  ```
- **Persistent suppression**: Add `warn-dirty = false` to your `~/.config/nix/nix.conf`.

## Development Conventions

- **Formatting**: All `.nix` files must be formatted using `alejandra`.
- **Linting**: Static analysis is performed via `statix` and `deadnix`.
- **Modularity**: New features or applications should be added as separate files in `modules/home-manager/` and imported in the relevant `hosts/*/home.nix`.
- **Transitions**: Preference is given to Home Manager configurations that are portable across NixOS and Arch Linux.
- **F2FS**: The system uses F2FS with specific compression extensions (`zstd:6`, `atgc`, etc.), managed in `modules/nixos/f2fs-extensions.nix`.

## Key Files

- `flake.nix`: The main entry point defining inputs and host configurations.
- `hosts/dell-desk/home.nix`: Home Manager configuration for the Dell desktop.
- `hosts/thinkpad/home.nix`: Home Manager configuration for the ThinkPad.
- `modules/home-manager/zsh.nix`: Zsh configuration including plugins.
- `modules/home-manager/hyprland.nix`: Hyprland window manager configuration.
- `nix/devshell.nix`: Definition of the `nix develop` shells.
