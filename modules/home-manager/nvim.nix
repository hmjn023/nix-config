{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  # Link the entire nvim config directory
  xdg.configFile."nvim".source = ./nvim;
}
