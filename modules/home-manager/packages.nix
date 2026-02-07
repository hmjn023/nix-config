{ config, pkgs, inputs, pkgs-latest, ... }:

{
  home.packages = with pkgs; [
    # Applications
    google-chrome
    discord
    kdePackages.dolphin
		pkgs-latest.antigravity
		vscode
		steam
		vivaldi
		
    # Gaming
    inputs.chaotic.packages.${pkgs.system}.proton-cachyos
    steam-run

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
		bat
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
