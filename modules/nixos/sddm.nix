{ pkgs, ... }:

{
  # Display Manager
  services = {
    displayManager.sddm = {
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
    xserver = {
      enable = true;
      xkb.layout = "jp";
    };
  };

  # Enable Hyprland system-wide for SDDM session detection
  programs.hyprland.enable = true;

  # SDDM Theme & Assets
  environment.systemPackages = with pkgs; [
    kdePackages.sddm
    kdePackages.breeze
    kdePackages.plasma-workspace
  ];
}
