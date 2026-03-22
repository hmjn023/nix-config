{ pkgs, ... }: {
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [ "Noto Serif CJK JP" "Noto Color Emoji" ];
      sansSerif = [ "Noto Sans CJK JP" "Noto Color Emoji" ];
      monospace = [ "Moralerspace Neon" "Noto Sans Mono CJK JP" "Noto Color Emoji" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };

  # ユーザーレベルで追加したいフォントがあればここに記述（システム側にあるなら不要）
  home.packages = with pkgs; [
    # システム側(modules/nixos/fonts.nix)で入れているので、
    # ここでは特定のアプリ用やユーザー固有のものがあれば追加します
  ];
}
