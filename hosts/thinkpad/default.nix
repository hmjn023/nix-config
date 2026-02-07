{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/nixos/hardware/thinkpad-fixes.nix
      ../../modules/nixos/sshd.nix
      ../../modules/nixos/i18n.nix
      ../../modules/nixos/sound.nix
      ../../modules/nixos/fonts.nix
      ../../modules/nixos/core.nix
      ../../modules/nixos/bluetooth.nix
      ../../modules/nixos/power.nix
      ../../modules/nixos/waydroid.nix
			../../modules/nixos/network.nix
    ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "f2fs" ];

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_cachyos;
  boot.kernelParams = [ "i915.force_probe=7d55" "i915.enable_guc=3" "nowatchdog" ];
  boot.kernelModules = [ "intel_vpu" ];

  # Networking
  networking.hostName = "thinkpad";
  networking.wireless.iwd.enable = true;
  networking.useDHCP = true;

  # Display Manager
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = false;
    package = pkgs.kdePackages.sddm;
    theme = "breeze";
    settings = {
      General = {
        InputMethod = "";
      };
    };
  };

  # XKB settings
  services.xserver.enable = true;
  services.xserver.xkb.layout = "jp";

  # Enable Hyprland system-wide for SDDM session detection
  programs.hyprland.enable = true;

  # User Account
  users.users.hmjn = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "video" "render" "docker" "input" ];
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
    usbutils

    # SDDM Theme & Assets
    kdePackages.sddm
    kdePackages.breeze
    kdePackages.plasma-workspace
  ];

  system.stateVersion = "25.11";
}
