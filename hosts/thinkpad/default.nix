{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/nixos/sshd.nix
      ../../modules/nixos/i18n.nix
      ../../modules/nixos/sound.nix
      ../../modules/nixos/fonts.nix
      ../../modules/nixos/core.nix
    ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "f2fs" ];

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_cachyos;
  # chaotic.scx.enable = true;

  # Networking
  networking.hostName = "thinkpad";
  networking.wireless.iwd.enable = true;
  networking.useDHCP = true;

  # User Account
  users.users.hmjn = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ];
    hashedPassword = "$6$Bh8Qjg9kNaQyaiUX$V5caBX7osT.52VhM2mKP45qr.EhjE.XbImwJqBwJFl5ZxSD9DxCxy2WggwiEfRHqZR3L0pnrdj1WMgxmrM6lZ1";
    packages = with pkgs; [
      tree
    ];
  };

  # System Packages
  environment.systemPackages = with pkgs; [
    # Core
    neovim
    git

    # System Utils
    wget
    curl
  ];

  system.stateVersion = "25.11";
}
