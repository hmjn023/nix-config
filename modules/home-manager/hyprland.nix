{pkgs, ...}: {
  # Services (Config only)
  services.swayosd.enable = true;
  services.hyprpaper.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    xwayland.enable = true;

    settings = {
      monitor = [",highres,auto,1"];
      env = [
        "XCURSOR_SIZE,24"
        "GTK_IM_MODULE,fcitx"
        "QT_IM_MODULE,fcitx"
        "XMODIFIERS,@im=fcitx"
      ];
      cursor.no_hardware_cursors = true;

      exec-once = [
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "waybar"
        "mako"
        "fcitx5"
        "[workspace 1 silent] wezterm"
        "[workspace 2 silent] google-chrome-stable"
        "[workspace 9 silent] discord-canary"
        "[workspace 10 silent] kitty btop"
      ];

      input = {
        kb_layout = "jp";
        follow_mouse = 1;
        touchpad.natural_scroll = "no";
        sensitivity = -0.5;
      };

      device = [
        {
          name = "elan0676:00-04f3:3195-mouse";
          sensitivity = -0.8;
          scroll_factor = 0.5;
        }
        {
          name = "elan0676:00-04f3:3195-touchpad";
          sensitivity = -0.8;
          scroll_factor = 0.5;
        }
        {
          name = "tpps/2-synaptics-trackpoint";
          sensitivity = -0.8;
          scroll_factor = 0.5;
        }
      ];
      general = {
        gaps_in = 2;
        gaps_out = 10;
        border_size = 5;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
      };
      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };
      };

      animations = {
        enabled = "yes";
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };

      misc = {
        force_default_wallpaper = 0;
        middle_click_paste = false;
      };

      "$mainMod" = "SUPER";
      bind = [
        # Applications
        "$mainMod, T, exec, kitty"
        "$mainMod, Return, exec, wezterm"
        "$mainMod, E, exec, dolphin"
        "$mainMod, D, exec, wofi --show drun -I"
        "CTRLSHIFT, Escape, exec, kitty btop"
        "$mainModShift, T, exec, kitty iwctl"
        "$mainMod, W, exec, $HOME/eww.sh"
        "$mainModShift, W, exec, $HOME/side.sh"

        # System
        "$mainModShift, Q, killactive,"
        "$mainModShift, E, exit,"
        "$mainModShift, Space, togglefloating,"
        "$mainMod, F, fullscreen"
        "$mainModShift, L, exec, swaylock -f --font \"Noto Sans Mono CJK JP\" -C ~/.config/swaylock/config"
        "$mainModShift, N, exec, swaync-client -t -sw"
        "$mainModShift, R, exec, hyprctl reload"

        # Screenshot & OCR
        "$mainModShift, S, exec, grim -g \"$(slurp)\" - | wl-copy"
        "$mainMod, O, exec, grim -g \"$(slurp)\" - | tesseract -l eng stdin stdout | sed \"s/ //g\" | wl-copy"
        "$mainModShift, O, exec, grim -g \"$(slurp)\" - | tesseract -l jpn+eng stdin stdout | sed \"s/ //g\" | wl-copy"

        # Audio & Brightness (swayosd)
        ", XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise"
        ", XF86AudioLowerVolume, exec, swayosd-client --output-volume lower"
        ", XF86AudioMute, exec, swayosd-client --output-volume mute-toggle"
        ", XF86AudioMicMute, exec, swayosd-client --input-volume mute-toggle"
        ", XF86MonBrightnessUp, exec, swayosd-client --brightness raise"
        ", XF86MonBrightnessDown, exec, swayosd-client --brightness lower"

        # Focus
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, K, movefocus, u"
        "$mainMod, J, movefocus, d"

        # Workspaces
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move to workspace
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Special workspace
        "$mainMod, S, togglespecialworkspace, magic"

        # Scroll workspaces
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];

      bindl = [
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioNext, exec, playerctl next"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };

  xdg.portal = {
    enable = true;
    config.common.default = "*";
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  # GUI helpers and app binaries are managed by pacman.
  home.packages = [];
}
