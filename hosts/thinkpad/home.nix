{pkgs, ...}: {
  imports = [
    ../../modules/home-manager/arch-packages.nix
    ../../modules/home-manager/zsh.nix
    ../../modules/home-manager/git.nix
    ../../modules/home-manager/ssh.nix
    ../../modules/home-manager/ranger.nix
    ../../modules/home-manager/tmux.nix
    ../../modules/home-manager/mise.nix
    ../../modules/home-manager/nvim.nix
    ../../modules/home-manager/hyprland.nix
    ../../modules/home-manager/waybar.nix
    ../../modules/home-manager/kitty.nix
    ../../modules/home-manager/wezterm.nix
    ../../modules/home-manager/swaylock.nix
    ../../modules/home-manager/gtk.nix
    ../../modules/home-manager/fonts.nix
    ../../modules/home-manager/proton-wrapper.nix
  ];

  home = {
    username = "hmjn";
    homeDirectory = "/home/hmjn";
    stateVersion = "24.11";
  };

  # Common CLI packages managed here
  home.packages = with pkgs; [
    gemini-cli
    kakasi
  ];

  programs.home-manager.enable = true;
}
