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
    trusted-users = [ "root" "hmjn" ];
  };

  programs.zsh.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-compute-runtime
      intel-graphics-compiler
      level-zero
      vpl-gpu-rt
			oneDNN_2
    ];
  };

  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if ((action.id == "org.freedesktop.login1.reboot" ||
           action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
           action.id == "org.freedesktop.login1.power-off" ||
           action.id == "org.freedesktop.login1.power-off-multiple-sessions") &&
          subject.isInGroup("wheel")) {
        return polkit.Result.YES;
      }
    });
  '';

  services.gvfs.enable = true;
  services.udisks2.enable = true;

  virtualisation.docker.enable = true;

  # Intel GPU環境変数
  environment.variables = {
    SYCL_CACHE_PERSISTENT = "1";
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
    zlib
    fuse3
    icu
    nss
    openssl
    curl
    expat
    glibc
    glib
    libGL
    libglvnd
    xorg.libX11
    xorg.libXext
    xorg.libXrender
    xorg.libXi
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXfixes
    xorg.libXrandr
    xorg.libXcursor
    xorg.libXtst
    alsa-lib
    nspr
    dbus
    at-spi2-atk
    at-spi2-core
    cups
    libdrm
    mesa
    libxkbcommon
    wayland
    
    # Intel GPU support
    level-zero
    intel-compute-runtime
    intel-media-driver
    oneDNN_2
  ];

  environment.pathsToLink = [ "/share/applications" "/share/xdg-desktop-portal" ];
}
