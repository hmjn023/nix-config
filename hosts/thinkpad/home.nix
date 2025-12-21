{ config, pkgs, ... }:

{
  imports = [
    ../../modules/home-manager/hyprland.nix
    ../../modules/home-manager/zsh.nix
    ../../modules/home-manager/mise.nix
    ../../modules/home-manager/nodejs.nix
    ../../modules/home-manager/git.nix
		../../modules/home-manager/gtk.nix
    ../../modules/home-manager/packages.nix
    ../../modules/home-manager/nvim.nix
    ../../modules/home-manager/kitty.nix
    ../../modules/home-manager/wezterm.nix
    ../../modules/home-manager/tmux.nix
    ../../modules/home-manager/zzz.nix
  ];

  home.username = "hmjn";
  home.homeDirectory = "/home/hmjn";
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}
