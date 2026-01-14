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
      ../../modules/nixos/bluetooth.nix
      ../../modules/nixos/power.nix
    ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "f2fs" ];

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_cachyos;
  boot.kernelParams = [ "i915.force_probe=7d55" "i915.enable_guc=3" "nowatchdog" ];
  boot.kernelModules = [ "intel_vpu" ];
  # chaotic.scx.enable = true;

  # Fix high CPU usage caused by ACPI interrupt storm (gpe6D)
  systemd.services.disable-gpe6d = {
    description = "Disable GPE 6D to prevent high CPU usage";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.runtimeShell} -c 'grep -q disabled /sys/firmware/acpi/interrupts/gpe6D || echo disable > /sys/firmware/acpi/interrupts/gpe6D'";
    };
  };

  # Networking
  networking.hostName = "thinkpad";
  networking.wireless.iwd.enable = true;
  networking.useDHCP = true;

  # Trackpoint Scroll & Sensitivity
  services.udev.extraRules = ''
    ACTION=="add|change", KERNEL=="event*", ATTRS{name}=="TPPS/2 Synaptics TrackPoint", ENV{LIBINPUT_SCROLL_METHOD}="button", ENV{LIBINPUT_SCROLL_BUTTON}="274", ENV{LIBINPUT_CONFIG_ACCEL_SPEED}="-0.5", ENV{LIBINPUT_SCROLL_PIXEL_DISTANCE}="50"
  '';



  # User Account
  users.users.hmjn = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "video" "render" "docker" ];
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
