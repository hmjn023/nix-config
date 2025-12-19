{ config, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    settings = {
      monitor = [
        ",highres,auto,1"
      ];

      exec-once = [
        "waybar"
      ];

      input = {
        kb_layout = "jp";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = false;
        };
      };
   
      "$mainMod" = "SUPER";
      bind = [
        "$mainMod, Enter, exec, wezterm"
        "$mainModShift, Q, killactive,"
        "$mainModShift, E, exit,"
        "$mainMod, E, exec, dolphin"
        "$mainModShift, Space, togglefloating,"

        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # ワークスペース移動 (1-9)
      ] ++ (
        map (n: "$mainMod, ${toString n}, workspace, ${toString n}") [1 2 3 4 5 6 7 8 9]
      ) ++ (
        map (n: "$mainMod SHIFT, ${toString n}, movetoworkspace, ${toString n}") [1 2 3 4 5 6 7 8 9]
      );
    };
  };
}
