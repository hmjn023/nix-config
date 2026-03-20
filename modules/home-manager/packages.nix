{
  pkgs,
  pkgs-latest,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    # Applications (GUI) - Managed by paru or Nix
    pkgs-latest.antigravity
    localsend
    vlc

    # Minecraft & Java (GraalVM)
    prismlauncher
    graalvmPackages.graalvm-ce # Latest GraalVM (Java 25)
    (lib.lowPrio graalvmPackages.graalvm-oracle_17) # GraalVM Java 17
    (lib.lowPrio zulu8) # Java 8 Fallback

    gemini-cli
  ];
  xdg.configFile."menus/applications.menu".source = "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";
}
