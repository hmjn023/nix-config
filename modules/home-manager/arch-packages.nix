{
  config,
  lib,
  ...
}: let
  # パッケージを種別ごとに管理
  paruPackages = {
    # Arch公式リポジトリおよびバイナリ配布 (Chaotic-AURなど)
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
      "google-chrome"
      "discord"
      "vesktop"
      "vivaldi"
      "localsend"
      "prismlauncher"
      "code" # Arch 'visual-studio-code-bin' or official 'code'
    ];

    # 純粋なAUR (手元でのビルドが必要なものなど)
    aur-build = [
      "swaylock-effects-git"
    ];

    # デスクトップ環境・GUIツール (OSネイティブのドライバが必要なもの)
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

  # すべてのパッケージを平坦なリストに変換
  allPackages = lib.flatten (lib.attrValues paruPackages);
  pkgsString = lib.concatStringsSep " " allPackages;
in {
  home.activation = {
    syncArchPackages = lib.hm.dag.entryAfter ["writeBoundary"] ''
      if command -v paru > /dev/null; then
        echo "Updating Arch Linux packages with paru..."
        # $DRY_RUN_CMD ensures compatibility with home-manager switch --dry-run
        $DRY_RUN_CMD paru -S --needed --noconfirm ${pkgsString}
      else
        echo "Warning: paru not found. Skipping Arch package sync."
      fi
    '';
  };
}
