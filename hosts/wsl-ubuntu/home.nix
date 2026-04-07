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

  home.sessionPath = [
    "$HOME/.nix-profile/bin"
  ];

  home.packages = with pkgs; [
    neovim
    lsd
    fd
    ripgrep
    jq
  ];

  programs.home-manager.enable = true;
  news.display = "silent";
}
