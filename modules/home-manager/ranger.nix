{ pkgs, ... }:

{
  home.packages = [ pkgs.ranger ];

  # Link the entire ranger config directory
  xdg.configFile."ranger".source = ./ranger;
}
