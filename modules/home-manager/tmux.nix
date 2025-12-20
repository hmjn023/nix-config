{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    mouse = true;
    historyLimit = 10000;
    sensibleOnTop = false; # sensible plugin handles this, but we'll include sensible manually via plugins if needed, or rely on hm defaults
    
    plugins = with pkgs.tmuxPlugins; [
      sensible
      urlview
    ];

    extraConfig = ''
      bind-key -T root WheelUpPane   if-shell -F -t = "#{alternate_on}" "send-keys -M" "select-pane -t =; copy-mode -e; send-keys -M"
      bind-key -T root WheelDownPane if-shell -F -t = "#{alternate_on}" "send-keys -M" "select-pane -t =; send-keys -M"
    '';
  };
}
