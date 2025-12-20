{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    max-substitution-jobs = 8;
    http-connections = 50;
    connect-timeout = 5;
    substituters = [
      "https://chaotic-nyx.cachix.org/"
    ];
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "root" "hmjn"];
  };

  programs.zsh.enable = true;
  
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    zlib
    fuse3
    icu
    nss
    openssl
    curl
    expat
    glibc
  ];
  
  environment.pathsToLink = [ "/share/applications" "/share/xdg-desktop-portal" ];
}
