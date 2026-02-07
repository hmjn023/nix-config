{
  pkgs,
  pkgs-latest,
  ...
}: {
  home.packages = with pkgs; [
    # Applications (GUI)
    google-chrome
    discord
    kdePackages.dolphin
    pkgs-latest.antigravity
    vscode
    vivaldi
  ];
}
