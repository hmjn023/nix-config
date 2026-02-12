{
  pkgs,
  pkgs-latest,
  ...
}: {
  home.packages = with pkgs; [
    # Applications (GUI)
    google-chrome
    pkgs-latest.discord-canary
    pkgs-latest.vesktop
    kdePackages.dolphin
    pkgs-latest.antigravity
    vscode
    vivaldi

    gemini-cli
  ];
}
