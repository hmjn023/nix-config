{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    package = pkgs.runCommand "kitty-dummy" {} "mkdir -p $out";
    font = {
      name = "NotoSansM Nerd Font Mono";
      size = 14;
    };

    settings = {
      scrollback_lines = 10000;
      enable_audio_bell = false;
      update_check_interval = 0;
      copy_on_select = "yes";

      # Performance
      input_delay = 3;
      sync_to_monitor = "yes";

      # Appearance
      background_opacity = "0.8";
      window_padding_width = 2;
    };

    # Keybindings
    keybindings = {
      "ctrl+c" = "copy_or_interrupt";
    };
  };
}
