{pkgs, ...}: {
  # System-wide Packages for Gaming
  environment.systemPackages = with pkgs; [
    steam-run
    proton-cachyos
  ];

  # Enable Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
}
