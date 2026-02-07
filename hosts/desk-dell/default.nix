{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/sshd.nix
    ../../modules/nixos/i18n.nix
    ../../modules/nixos/sound.nix
    ../../modules/nixos/fonts.nix
    ../../modules/nixos/core.nix
    ../../modules/nixos/bluetooth.nix
    ../../modules/nixos/waydroid.nix
    ../../modules/nixos/network.nix
    ../../modules/nixos/sddm.nix
    ../../modules/nixos/packages.nix
    ../../modules/nixos/steam.nix
    ../../modules/nixos/nvidia.nix
  ];

  # Bootloader
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    # Kernel
    kernelPackages = pkgs.linuxPackages_cachyos;
  };

  # Networking
  networking = {
    hostName = "desk-dell";
    wireless.iwd.enable = true;
    useDHCP = true;
  };

  # Monitor configuration (Example for Desktop)
  system.monitors = [
    {
      name = "DP-1";
      resolution = "3840x2160";
      position = "0x0";
      scale = "1";
    }
    {
      name = "HDMI-A-1";
      resolution = "1920x1080";
      position = "3840x0";
      scale = "1";
    }
  ];

  # User Account
  users.users.hmjn = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = ["wheel" "video" "render" "docker" "input"];
    hashedPassword = "$6$Bh8Qjg9kNaQyaiUX$V5caBX7osT.52VhM2mKP45qr.EhjE.XbImwJqBwJFl5ZxSD9DxCxy2WggwiEfRHqZR3L0pnrdj1WMgxmrM6lZ1";
  };

  system.stateVersion = "25.11";
}
