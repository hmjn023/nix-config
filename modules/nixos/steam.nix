{
  pkgs,
  inputs,
  ...
}: {
  # System-wide Packages for Gaming
  environment.systemPackages = with pkgs; [
    steam-run
    inputs.chaotic.packages.${pkgs.stdenv.hostPlatform.system}.proton-cachyos
  ];

  # Enable Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
}
