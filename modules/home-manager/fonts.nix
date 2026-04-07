{pkgs, ...}: {
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = ["Noto Serif CJK JP" "Noto Color Emoji"];
      sansSerif = ["Noto Sans CJK JP" "Noto Color Emoji"];
      monospace = ["Moralerspace Neon" "Noto Sans Mono CJK JP" "Noto Color Emoji"];
      emoji = ["Noto Color Emoji"];
    };
  };

  # Optional: Define user-level fonts (typically managed by Arch system-wide)
  home.packages = with pkgs; [
    # Already included via system-wide configuration (modules/nixos/fonts.nix)
    # Add user-specific or application-specific fonts here if needed
  ];
}
