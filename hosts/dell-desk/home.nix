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
      "DP-3, 3840x2160@60, 0x0, 1"
    ];
    workspaceRules = [
      "1, monitor:DP-3"
      "2, monitor:DP-3"
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
