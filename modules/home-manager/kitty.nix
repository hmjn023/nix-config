_: {
  programs.kitty = {
    enable = true;

    font = {
      name = "NotoSansM Nerd Font Mono";
      size = 14;
    };

    settings = {
      # Fonts
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      force_ltr = "no";
      disable_ligatures = "never";

      # Cursor
      cursor = "#cccccc";
      cursor_text_color = "#111111";
      cursor_shape = "block";
      cursor_beam_thickness = "1.5";
      cursor_underline_thickness = "2.0";
      cursor_blink_interval = "-1";
      cursor_stop_blinking_after = "15.0";

      # Scrollback
      scrollback_lines = 2000;
      scrollback_pager = "less --chop-long-lines --RAW-CONTROL-CHARS +INPUT_LINE_NUMBER";
      scrollback_pager_history_size = 0;
      scrollback_fill_enlarged_window = "no";
      wheel_scroll_multiplier = "5.0";
      wheel_scroll_min_lines = 1;
      touch_scroll_multiplier = "1.0";

      # Mouse
      mouse_hide_wait = "3.0";
      url_color = "#0087bd";
      url_style = "curly";
      open_url_with = "default";
      detect_urls = "yes";
      copy_on_select = "no";
      paste_actions = "quote-urls-at-prompt";
      strip_trailing_spaces = "never";
      select_by_word_characters = "@-./_~?&=%+#";
      click_interval = "-1.0";
      focus_follows_mouse = "no";
      pointer_shape_when_grabbed = "arrow";
      default_pointer_shape = "beam";
      pointer_shape_when_dragging = "beam";
      clear_all_mouse_actions = "no";

      # Performance
      repaint_delay = 10;
      input_delay = 3;
      sync_to_monitor = "yes";

      # Bell
      enable_audio_bell = "yes";
      visual_bell_duration = "0.0";
      visual_bell_color = "none";
      window_alert_on_bell = "yes";
      bell_on_tab = "\"🔔 \"";
      command_on_bell = "none";
      bell_path = "none";

      # Window layout
      remember_window_size = "yes";
      initial_window_width = 640;
      initial_window_height = 400;
      enabled_layouts = "*";
      window_resize_step_cells = 2;
      window_resize_step_lines = 2;
      window_border_width = "0.5pt";
      draw_minimal_borders = "yes";
      window_margin_width = 0;
      single_window_margin_width = "-1";
      window_padding_width = 0;
      placement_strategy = "center";
      active_border_color = "#00ff00";
      inactive_border_color = "#cccccc";
      bell_border_color = "#ff5a00";
      inactive_text_alpha = "1.0";
      hide_window_decorations = "no";
      window_logo_path = "none";
      window_logo_position = "bottom-right";
      window_logo_alpha = "0.5";
      resize_debounce_time = "0.1";
      resize_in_steps = "no";
      visual_window_select_characters = "1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ";
      confirm_os_window_close = "-1";

      # Tab bar
      tab_bar_edge = "bottom";
      tab_bar_margin_width = "0.0";
      tab_bar_margin_height = "0.0 0.0";
      tab_bar_style = "fade";
      tab_bar_align = "left";
      tab_bar_min_tabs = 2;
      tab_switch_strategy = "previous";
      tab_fade = "0.25 0.5 0.75 1";
      tab_separator = "\" ┇\"";
      tab_powerline_style = "angled";
      tab_activity_symbol = "none";
      tab_title_template = "\"{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{title}\"";
      active_tab_title_template = "none";
      active_tab_foreground = "#000";
      active_tab_background = "#eee";
      active_tab_font_style = "bold-italic";
      inactive_tab_foreground = "#444";
      inactive_tab_background = "#999";
      inactive_tab_font_style = "normal";
      tab_bar_background = "none";
      tab_bar_margin_color = "none";

      # Color scheme
      foreground = "#dddddd";
      background = "#000000";
      background_opacity = "0.8";
      background_image = "none";
      background_image_layout = "tiled";
      background_image_linear = "no";
      dynamic_background_opacity = "no";
      background_tint = "0.0";
      dim_opacity = "0.75";
      selection_foreground = "#000000";
      selection_background = "#fffacd";

      # Color table
      color0 = "#000000";
      color8 = "#767676";
      color1 = "#cc0403";
      color9 = "#f2201f";
      color2 = "#19cb00";
      color10 = "#23fd00";
      color3 = "#cecb00";
      color11 = "#fffd00";
      color4 = "#0d73cc";
      color12 = "#1a8fff";
      color5 = "#cb1ed1";
      color13 = "#fd28ff";
      color6 = "#0dcdcd";
      color14 = "#14ffff";
      color7 = "#dddddd";
      color15 = "#ffffff";
      mark1_foreground = "black";
      mark1_background = "#98d3cb";
      mark2_foreground = "black";
      mark2_background = "#f2dcd3";
      mark3_foreground = "black";
      mark3_background = "#f274bc";

      # Advanced
      shell = ".";
      editor = ".";
      close_on_child_death = "no";
      allow_remote_control = "no";
      listen_on = "none";
      update_check_interval = 24;
      startup_session = "none";
      clipboard_control = "write-clipboard write-primary read-clipboard-ask read-primary-ask";
      clipboard_max_size = 64;
      allow_hyperlinks = "yes";
      shell_integration = "enabled";
      allow_cloning = "ask";
      clone_source_strategies = "venv,conda,env_var,path";
      term = "xterm-kitty";

      # OS specific tweaks
      wayland_titlebar_color = "system";
      linux_display_server = "auto";
    };

    keybindings = {
      "kitty_mod+c" = "copy_to_clipboard";
      "cmd+c" = "copy_to_clipboard";
      "kitty_mod+v" = "paste_from_clipboard";
      "cmd+v" = "paste_from_clipboard";
      "kitty_mod+s" = "paste_from_selection";
      "shift+insert" = "paste_from_selection";
      "kitty_mod+o" = "pass_selection_to_program";
      "kitty_mod+up" = "scroll_line_up";
      "kitty_mod+k" = "scroll_line_up";
      "opt+cmd+page_up" = "scroll_line_up";
      "cmd+up" = "scroll_line_up";
      "kitty_mod+down" = "scroll_line_down";
      "kitty_mod+j" = "scroll_line_down";
      "opt+cmd+page_down" = "scroll_line_down";
      "cmd+down" = "scroll_line_down";
      "kitty_mod+page_up" = "scroll_page_up";
      "cmd+page_up" = "scroll_page_up";
      "kitty_mod+page_down" = "scroll_page_down";
      "cmd+page_down" = "scroll_page_down";
      "kitty_mod+home" = "scroll_home";
      "cmd+home" = "scroll_home";
      "kitty_mod+end" = "scroll_end";
      "cmd+end" = "scroll_end";
      "kitty_mod+z" = "scroll_to_prompt -1";
      "kitty_mod+x" = "scroll_to_prompt 1";
      "kitty_mod+h" = "show_scrollback";
      "kitty_mod+g" = "show_last_command_output";
      "kitty_mod+enter" = "new_window";
      "cmd+enter" = "new_window";
      "kitty_mod+n" = "new_os_window";
      "cmd+n" = "new_os_window";
      "kitty_mod+w" = "close_window";
      "shift+cmd+d" = "close_window";
      "kitty_mod+]" = "next_window";
      "kitty_mod+[" = "previous_window";
      "kitty_mod+f" = "move_window_forward";
      "kitty_mod+b" = "move_window_backward";
      "kitty_mod+`" = "move_window_to_top";
      "kitty_mod+r" = "start_resizing_window";
      "cmd+r" = "start_resizing_window";
      "kitty_mod+1" = "first_window";
      "cmd+1" = "first_window";
      "kitty_mod+2" = "second_window";
      "cmd+2" = "second_window";
      "kitty_mod+3" = "third_window";
      "cmd+3" = "third_window";
      "kitty_mod+4" = "fourth_window";
      "cmd+4" = "fourth_window";
      "kitty_mod+5" = "fifth_window";
      "cmd+5" = "fifth_window";
      "kitty_mod+6" = "sixth_window";
      "cmd+6" = "sixth_window";
      "kitty_mod+7" = "seventh_window";
      "cmd+7" = "seventh_window";
      "kitty_mod+8" = "eighth_window";
      "cmd+8" = "eighth_window";
      "kitty_mod+9" = "ninth_window";
      "cmd+9" = "ninth_window";
      "kitty_mod+0" = "tenth_window";
      "kitty_mod+f7" = "focus_visible_window";
      "kitty_mod+f8" = "swap_with_window";
      "kitty_mod+right" = "next_tab";
      "shift+cmd+]" = "next_tab";
      "ctrl+tab" = "next_tab";
      "kitty_mod+left" = "previous_tab";
      "shift+cmd+[" = "previous_tab";
      "ctrl+shift+tab" = "previous_tab";
      "kitty_mod+t" = "new_tab";
      "cmd+t" = "new_tab";
      "kitty_mod+q" = "close_tab";
      "cmd+w" = "close_tab";
      "shift+cmd+w" = "close_os_window";
      "kitty_mod+." = "move_tab_forward";
      "kitty_mod+," = "move_tab_backward";
      "kitty_mod+alt+t" = "set_tab_title";
      "shift+cmd+i" = "set_tab_title";
      "kitty_mod+l" = "next_layout";
      "kitty_mod+equal" = "change_font_size all +2.0";
      "kitty_mod+plus" = "change_font_size all +2.0";
      "kitty_mod+kp_add" = "change_font_size all +2.0";
      "cmd+plus" = "change_font_size all +2.0";
      "cmd+equal" = "change_font_size all +2.0";
      "shift+cmd+equal" = "change_font_size all +2.0";
      "kitty_mod+minus" = "change_font_size all -2.0";
      "kitty_mod+kp_subtract" = "change_font_size all -2.0";
      "cmd+minus" = "change_font_size all -2.0";
    };
  };
}
