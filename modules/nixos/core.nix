{ config, lib, pkgs, ... }:

{
  options.system.monitors = lib.mkOption {
    type = lib.types.listOf (lib.types.submodule {
      options = {
        name = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = "Monitor name (e.g., eDP-1). Empty string means default monitor (',').";
        };
        resolution = lib.mkOption {
          type = lib.types.str;
          default = "preferred";
          description = "Monitor resolution (e.g., 1920x1080@60).";
        };
        position = lib.mkOption {
          type = lib.types.str;
          default = "auto";
          description = "Monitor position (e.g., 0x0).";
        };
        scale = lib.mkOption {
          type = lib.types.str;
          default = "1";
          description = "Monitor scale.";
        };
      };
    });
    default = [ { name = ""; resolution = "preferred"; position = "auto"; scale = "1"; } ];
    description = "List of monitor configurations.";
  };

  config = {
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

  environment.systemPackages = with pkgs; [
    (btop.overrideAttrs (oldAttrs: {
      src = fetchFromGitHub {
        owner = "deveworld";
        repo = "btop";
        rev = "8fb739059f5a31dfa5cd3f78b724ff5b16a0a379";
        hash = "sha256-k9HJc36QC436wnbj2qL/rK+CzYEsZIzi+XU/3hZy0oE=";
      };
    }))
  ];

  security.wrappers.btop = {
    source = "${pkgs.btop.overrideAttrs (oldAttrs: {
      src = pkgs.fetchFromGitHub {
        owner = "deveworld";
        repo = "btop";
        rev = "8fb739059f5a31dfa5cd3f78b724ff5b16a0a379";
        hash = "sha256-k9HJc36QC436wnbj2qL/rK+CzYEsZIzi+XU/3hZy0oE=";
      };
    })}/bin/btop";
    capabilities = "cap_perfmon=+ep";
    owner = "root";
    group = "root";
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-compute-runtime
      intel-compute-runtime.drivers
      intel-graphics-compiler
      intel-npu-driver
      level-zero
      vpl-gpu-rt
			oneDNN_2
    ];
  };

  boot.kernel.sysctl = {
    "dev.i915.perf_stream_paranoid" = 0;
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

  # Controller support
  hardware.uinput.enable = true;
  services.udev.packages = [ pkgs.game-devices-udev-rules ];

  # Intel GPU環境変数
  environment.variables = {
    SYCL_CACHE_PERSISTENT = "1";
    LIBVA_DRIVER_NAME = "iHD";
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
    
    # Intel GPU and NPU support
    level-zero
    intel-compute-runtime
    intel-media-driver
    intel-npu-driver
    oneDNN_2
  ];

  environment.pathsToLink = [ "/share/applications" "/share/xdg-desktop-portal" ];
  };
}
