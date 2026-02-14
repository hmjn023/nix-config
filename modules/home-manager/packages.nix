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
    kdePackages.kio-extras
    kdePackages.kdegraphics-thumbnailers
    kdePackages.kimageformats
    kdePackages.ffmpegthumbs
    pkgs-latest.antigravity
    vscode
    vivaldi

    gemini-cli
  ];
}
