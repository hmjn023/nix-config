{
  config,
  pkgs,
  ni-zsh,
  zsh-romaji-complete,
  ...
}: {
  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
    "${config.home.homeDirectory}/Android/Sdk/platform-tools"
    "${config.home.homeDirectory}/flutter/bin"
    "${config.home.homeDirectory}/go/bin"
    "${config.home.homeDirectory}/.cargo/bin"
    "${config.home.homeDirectory}/.bun/bin"
    "/var/lib/snapd/snap/bin"
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # History settings
    history = {
      size = 100000;
      save = 100000;
      path = "${config.home.homeDirectory}/.history";
      extended = true;
    };

    # Shell aliases
    shellAliases = {
      vi = "nvim";
      cd = "z";
      ls = "lsd";
      la = "ls -a";
      ll = "ls -ls";
      lh = "ls -lh";

      # Home Manager Flake aliases
      hm = "nix run home-manager/master -- --flake .#hmjn";
      hms = "nix run home-manager/master -- --flake .#hmjn switch";
      hmn = "nix run home-manager/master -- --flake .#hmjn news";
    };

    # Session variables
    sessionVariables = {
      GOPATH = "${config.home.homeDirectory}/go";
      ANDROID_HOME = "${config.home.homeDirectory}/Android/Sdk";
      NDK_HOME = "${config.home.homeDirectory}/Android/Sdk/ndk/26.3.11579264";
      CARGO_HOME = "${config.home.homeDirectory}/.cargo";
      VISUAL = "nvim";
      EDITOR = "nvim";
      BROWSER = "google-chrome-stable";
      VCPKG_ROOT = "/opt/vcpkg";
      VCPKG_DOWNLOADS = "/var/cache/vcpkg";
      MAKEFLAGS = "-j$(nproc --all)";
    };

    # Environment variables (loaded first in .zshenv)
    envExtra = ''
      # Skip WezTerm's heavy automatic shell integration
      export WEZTERM_SHELL_SKIP_ALL=1
    '';

    # Extra initialization
    initExtra = ''
      # CHROME_EXECUTABLE for some tools
      if command -v google-chrome-stable &> /dev/null; then
        export CHROME_EXECUTABLE=$(which google-chrome-stable)
      fi

      # Completions for tools not managed by Nix/Home Manager integration
      if command -v uv &> /dev/null; then
        eval "$(uv generate-shell-completion zsh)"
      fi

      if command -v npm &> /dev/null; then
        eval "$(npm completion)"
      fi

      # Lightweight WezTerm directory tracking (OSC 7)
      if [[ "$TERM_PROGRAM" == "WezTerm" ]]; then
        function wezterm_osc7_precmd() {
          printf "\033]7;file://%s%s\033\\" "$HOST" "$PWD"
        }
        autoload -Uz add-zsh-hook
        add-zsh-hook precmd wezterm_osc7_precmd
      fi

      # Key settings (terminfo based)
      typeset -g -A key
      key[Home]="''${terminfo[khome]}"
      key[End]="''${terminfo[kend]}"
      key[Insert]="''${terminfo[kich1]}"
      key[Backspace]="''${terminfo[kbs]}"
      key[Delete]="''${terminfo[kdch1]}"
      key[Up]="''${terminfo[kcuu1]}"
      key[Down]="''${terminfo[kcud1]}"
      key[Left]="''${terminfo[kcub1]}"
      key[Right]="''${terminfo[kcuf1]}"
      key[PageUp]="''${terminfo[kpp]}"
      key[PageDown]="''${terminfo[knp]}"
      key[Shift-Tab]="''${terminfo[kcbt]}"

      [[ -n "''${key[Home]}"      ]] && bindkey "''${key[Home]}"       beginning-of-line
      [[ -n "''${key[End]}"       ]] && bindkey "''${key[End]}"        end-of-line
      [[ -n "''${key[Insert]}"    ]] && bindkey "''${key[Insert]}"     overwrite-mode
      [[ -n "''${key[Backspace]}" ]] && bindkey "''${key[Backspace]}"  backward-delete-char
      [[ -n "''${key[Delete]}"    ]] && bindkey "''${key[Delete]}"     delete-char
      [[ -n "''${key[Up]}"        ]] && bindkey "''${key[Up]}"         up-line-or-history
      [[ -n "''${key[Down]}"      ]] && bindkey "''${key[Down]}"       down-line-or-history
      [[ -n "''${key[Left]}"      ]] && bindkey "''${key[Left]}"       backward-char
      [[ -n "''${key[Right]}"     ]] && bindkey "''${key[Right]}"      forward-char
      [[ -n "''${key[PageUp]}"    ]] && bindkey "''${key[PageUp]}"     beginning-of-buffer-or-history
      [[ -n "''${key[PageDown]}"  ]] && bindkey "''${key[PageDown]}"   end-of-buffer-or-history
      [[ -n "''${key[Shift-Tab]}" ]] && bindkey "''${key[Shift-Tab]}"  reverse-menu-complete

      if (( ''${+terminfo[smkx]} && ''${+terminfo[rmkx]} )); then
              autoload -Uz add-zle-hook-widget
              function zle_application_mode_start { echoti smkx }
              function zle_application_mode_stop { echoti rmkx }
              add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
              add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
      fi

      bindkey "^I" menu-expand-or-complete

      # Broot integration
      if [ -f $HOME/.config/broot/launcher/bash/br ]; then
        source $HOME/.config/broot/launcher/bash/br
      fi

      # Unset SSH_ASKPASS to prevent annoying GUI prompts
      unset SSH_ASKPASS
    '';

    # Plugins (managed by Flake inputs)
    plugins = [
      {
        name = "zsh-romaji-complete";
        src = zsh-romaji-complete;
      }
      {
        name = "ni";
        src = ni-zsh;
      }
    ];
  };

  # Optimized initialization for CLI tools
  programs = {
    starship = {
      enable = true;
      enableZshIntegration = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    mcfly = {
      enable = true;
      enableZshIntegration = true;
      keyScheme = "emacs";
    };
  };
}
