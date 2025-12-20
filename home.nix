{ config, pkgs, ... }:

{
  home.username = "hmjn";
  home.homeDirectory = "/home/hmjn";
  home.stateVersion = "24.11";
  home.sessionVariables = {
    NODEJS_CHECK_BINARY = "0";
  };
  home.sessionVariables = {
    npm_config_prefix = "$HOME/.npm-global";
  };
  home.sessionPath = [
    "$HOME/.npm-global/bin"
  ];
  home.packages = [
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };

  programs.mise = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      all_compile = false;      # 強制コンパイルをオフ
      experimental = true;     # もし新しい機能を使うなら
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = [
        ",1920x1200,auto,1"
      ];

      exec-once = [
        "waybar"
	"fcitx5 -d"
      ];

      input = {
        kb_layout = "jp";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = false;
        };
      };

      general = {
        gaps_in = 2;
        gaps_out = 10;
        border_size = 5;
	"col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
	"col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
	allow_tearing = false;
      };

      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };
      };


   
      "$mainMod" = "SUPER";
      bind = [
        "$mainMod, Return, exec, wezterm"
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
  programs.home-manager.enable = true;
}
