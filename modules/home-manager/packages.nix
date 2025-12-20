{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Applications
    google-chrome
    discord
    
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
    
    # Dev
    gcc
    gnumake
    python3
		viu
  ];
}
