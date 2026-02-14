{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/f2fs.nix
    ../../modules/nixos/sshd.nix
    ../../modules/nixos/i18n.nix
    ../../modules/nixos/sound.nix
    ../../modules/nixos/fonts.nix
    ../../modules/nixos/core.nix
    ../../modules/nixos/intel.nix
    ../../modules/nixos/bluetooth.nix
    ../../modules/nixos/power.nix
    ../../modules/nixos/waydroid.nix
    ../../modules/nixos/network.nix
    ../../modules/nixos/sddm.nix
    ../../modules/nixos/packages.nix
    ../../modules/nixos/steam.nix
  ];

  # Bootloader
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    # Kernel
    kernelPackages = pkgs.linuxPackages_cachyos;
    kernelModules = ["intel_vpu" "acpi_call" "thinkpad_acpi"];
    extraModulePackages = with pkgs.linuxPackages_cachyos; [acpi_call];
    kernelParams = [
      "acpi_mask_gpe=0x6D,0x6E"
      # Modern Standby (S0ix) optimizations
      "i915.enable_guc=3" # Enable GuC/HuC for better GPU power management
      "i915.enable_dc=4" # Enable deeper Display Power C-states
      "nvme.noacpi=1" # Sometimes helps NVMe reach deeper sleep states
      "pcie_aspm=force" # Force Active State Power Management
    ];
  };

  # Networking
  networking = {
    hostName = "thinkpad";
    wireless.iwd.enable = true;
    useDHCP = true;
  };

  # Monitor configuration
  system.monitors = [
    {
      name = "eDP-1";
      resolution = "1920x1200";
      position = "0x0";
      scale = "1";
    }
    {
      name = "DP-1";
      resolution = "3840x2160";
      position = "1920x0";
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
