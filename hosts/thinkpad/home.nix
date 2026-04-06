{
  pkgs,
  ni-zsh,
  zsh-romaji-complete,
  ...
}: {
  imports = [
    ../../modules/home-manager/arch/default.nix
    ../../modules/home-manager/arch/binaries.nix
    ../../modules/home-manager/arch/aur-build.nix
    ../../modules/home-manager/arch/desktop.nix
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

  my.hyprland = {
    monitors = [
      "eDP-1, 1920x1200@60, 0x0, 1.25"
    ];
  };

  home = {
    username = "hmjn";
    homeDirectory = "/home/hmjn";
    stateVersion = "24.11";
  };

  # Common CLI packages managed here
  home.packages = with pkgs; [];

  programs.home-manager.enable = true;
  news.display = "silent";
}
