{pkgs, ...}: {
  programs.wezterm = {
    enable = true;
    # Arch Linuxなどのホスト側でバイナリを管理している場合のため
    package = pkgs.runCommand "wezterm-dummy" {} "mkdir -p $out";
    enableZshIntegration = false;
    extraConfig = builtins.readFile ./wezterm/wezterm.lua;
  };
}
