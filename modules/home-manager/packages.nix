{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    # Applications
    google-chrome
    discord
    kdePackages.dolphin
		antigravity
		vscode
		
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
		tree-sitter
		bat
		dua
		ouch
		gh

    # Dev
    gcc
    gnumake
    python3
  ];
}
