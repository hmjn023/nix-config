{pkgs, ...}: {
  programs.wezterm = {
    enable = true;
    package = pkgs.runCommand "wezterm-dummy" {} "mkdir -p $out";
    enableZshIntegration = false;
    extraConfig = ''
      -- Pull in the wezterm API
      local wezterm = require("wezterm")

      -- This table will hold the configuration.
      local config = wezterm.config_builder()

      -- Font configuration
      config.font = wezterm.font("Moralerspace Neon")
      config.font_size = 14.0

      -- Color scheme
      config.color_scheme = "AdventureTime"

      -- Appearance
      config.enable_tab_bar = false
      config.window_background_opacity = 0.8
      config.window_padding = {
        left = 2,
        right = 2,
        top = 2,
        bottom = 2,
      }

      -- Performance
      config.front_end = "WebGpu"

      -- Default key assignments
      config.disable_default_key_bindings = false

      -- and finally, return the configuration to wezterm
      return config
    '';
  };
}
