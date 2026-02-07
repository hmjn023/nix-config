{ pkgs, ... }:

{
  # System-wide Packages
  environment.systemPackages = with pkgs; [
    # Core
    neovim
    git
    wget
    curl
    usbutils
    tree

    # CLI Tools
    f2fs-tools
    xdg-utils
    lsd
    starship
    zoxide
    mcfly
    bat
    ripgrep
    fd
    jq
    viu
    kakasi
    tree-sitter
    dua
    ouch
    gh
    yt-dlp

    # Dev
    gcc
    gnumake
    python3
    uv
    clinfo
    vulkan-tools
  ];
}
