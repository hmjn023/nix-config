{
  pkgs,
  ni-zsh,
  zsh-romaji-complete,
  ...
}: {
  imports = [
    ../../modules/home-manager/zsh.nix
    ../../modules/home-manager/git.nix
../../modules/home-manager/ranger.nix
    ../../modules/home-manager/tmux.nix
    ../../modules/home-manager/mise.nix
    ../../modules/home-manager/nvim.nix
  ];

  home = {
    username = "hmjn";
    homeDirectory = "/home/hmjn";
    stateVersion = "24.11";
  };

  home.packages = with pkgs; [];

  programs.home-manager.enable = true;
  news.display = "silent";
}
