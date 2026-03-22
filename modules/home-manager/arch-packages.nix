{
  config,
  lib,
  ...
}: let
  # Manage packages by category
  paruPackages = {
    # Arch official repositories and binary distributions (e.g., Chaotic-AUR)
    binaries = [
      "base-devel"
      "git"
      "neovim"
      "tmux"
      "fastfetch"
      "btop"
      "eza"
      "fzf"
      "jq"
      "ripgrep"
      "fd"
      "bat"
      "wl-clipboard"
      "libnotify"
      "grim"
      "slurp"
      "google-chrome"
      "discord"
      "vesktop"
      "vivaldi"
      "localsend"
      "prismlauncher"
      "code" # Arch 'visual-studio-code-bin' or official 'code'
    ];

    # Pure AUR (packages that require local building)
    aur-build = [
      "swaylock-effects-git"
      "antigravity"
    ];

    # Desktop environment and GUI tools (requiring native drivers)
    desktop = [
      "hyprland"
      "kitty"
      "wezterm-git"
      "pavucontrol"
      "waybar"
      "dolphin"
      "vlc"
      "jdk-openjdk" # Satisfy java-runtime dependency for prismlauncher
    ];
  };

  # Flatten all packages into a single list
  allPackages = lib.flatten (lib.attrValues paruPackages);
  pkgsString = lib.concatStringsSep " " allPackages;
in {
  home.activation = {
    syncArchPackages = lib.hm.dag.entryAfter ["writeBoundary"] ''
      if command -v paru > /dev/null; then
        # Identify missing packages using paru -T (checks for satisfaction)
        # We use xargs to handle potential empty input and clean up the list
        MISSING_PKGS=$(paru -T ${pkgsString} | xargs)

        if [ -n "$MISSING_PKGS" ]; then
          echo "Installing missing Arch Linux packages: $MISSING_PKGS"
          # Use $DRY_RUN_CMD for compatibility with home-manager switch --dry-run
          $DRY_RUN_CMD paru -S --noconfirm --needed $MISSING_PKGS
        fi
      else
        echo "Warning: 'paru' not found. Skipping Arch Linux package synchronization."
      fi
    '';
  };
}

