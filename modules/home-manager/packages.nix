{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    # Applications
    google-chrome
    discord

    # Gaming
    inputs.chaotic.packages.${pkgs.system}.proton-cachyos
    steam-run

    # CLI Tools
    btop
    f2fs-tools
    xdg-utils
    lsd
    starship
    zoxide
    mcfly
    sheldon
    bat
    ripgrep
    fd
    jq
    viu
    kakasi

    # Dev
    gcc
    gnumake
    python3
  ];
}
