{
  pkgs,
  pkgs-latest,
  lib,
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
		kdePackages.qtsvg
		kdePackages.kservice
    pkgs-latest.antigravity
    vscode
    vivaldi
    localsend

    # Minecraft & Java (GraalVM)
    prismlauncher
    graalvmPackages.graalvm-ce # Latest GraalVM (Java 25)
    (lib.lowPrio graalvmPackages.graalvm-oracle_17) # GraalVM Java 17
    (lib.lowPrio zulu8) # Java 8 Fallback

    gemini-cli
  ];
	xdg.configFile."menus/applications.menu".source = "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";
}
