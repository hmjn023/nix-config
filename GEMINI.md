# Output Format (STRICT)

- **Language**: Always start your response with a brief analysis and plan in **Japanese**.
- **Code**: Use **English** for code snippets, variable names, and technical comments.
- **Content**: Always use **English** for any text, documentation, or comments added to the codebase.

---

# NixOS Configuration Project

## Project Overview

This repository contains a modular **NixOS configuration** managed with **Nix Flakes** and **Home Manager**. It is designed to provide a reproducible, declarative system environment, currently targeting a host named `thinkpad`.

The configuration leverages **NixOS Unstable** and **Chaotic Nyx** for the latest packages and performance optimizations (including CachyOS kernel).

## Architecture

The project is structured to separate concerns between the flake entry point, host-specific configurations, and reusable modules.

### Directory Structure

*   **`flake.nix`**: The entry point. Defines inputs (nixpkgs, chaotic-nyx, home-manager) and the `nixosConfigurations` output.
*   **`hosts/`**: Contains configurations specific to a particular machine.
    *   **`thinkpad/`**:
        *   `default.nix`: Main system configuration (imports system modules, bootloader, kernel, networking).
        *   `home.nix`: Home Manager entry point (imports user modules).
        *   `hardware-configuration.nix`: Hardware specifics (generated).
*   **`modules/`**: Contains reusable configuration blocks.
    *   **`nixos/`**: System-level modules (e.g., `core.nix`, `fonts.nix`, `i18n.nix`, `sound.nix`, `sshd.nix`).
        *   **`hardware/`**: Hardware-specific fixes and configurations (e.g., `thinkpad-fixes.nix`).
    *   **`home-manager/`**: User-level modules (e.g., `hyprland.nix`, `zsh.nix`, `kitty.nix`, `wezterm.nix`, `tmux.nix`, `packages.nix`).
        *   `proton-wrapper.nix`: Custom wrapper for running Proton in a steam-run FHS environment.
*   **`.dotfiles/`**: Legacy dotfiles directory. All configurations have been migrated to native Nix expressions in `modules/home-manager/`. This directory is no longer used by the current Nix configuration.

## Key Features

*   **Window Manager**: Hyprland (Wayland) configured via `modules/home-manager/hyprland.nix`.
*   **Shell**: Zsh managed by Home Manager.
*   **Terminals**: Kitty and Wezterm, configured via Nix.
*   **Kernel**: CachyOS kernel (`linuxPackages_cachyos`) for performance.
*   **Networking**: Uses `iwd` for wireless connections.

## Building and Running

### Applying Configuration

To apply the configuration to the current system:

```bash
sudo nixos-rebuild switch --flake .
```

### Updating Inputs

To update the flake inputs (nixpkgs, etc.) to their latest versions:

```bash
nix flake update
```

### Formatting

To format the codebase (using `nixpkgs-fmt` as defined in `flake.nix`):

```bash
nix fmt
```

## Development Conventions

*   **Modularization**: Avoid monolithic files. Split configuration into logical units (e.g., separate files for `hyprland`, `zsh`, `fonts`) and place them in `modules/`.
*   **Pure Nix**: Prefer defining configuration directly in Nix expressions rather than symlinking raw config files, to fully leverage Nix's declarative nature.
*   **Home Manager**: User-specific software and configuration should go into Home Manager modules, not system-wide configuration.
*   **NixOS Unstable**: The system tracks the unstable channel. Be aware of potential breakage during updates.