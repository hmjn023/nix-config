{
  config,
  pkgs,
  ...
}: {
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
    };

    # Session variables
    sessionVariables = {
      HISTFILE = "${config.home.homeDirectory}/.history";
      HISTSIZE = "100000";
      SAVEHIST = "100000";
      # PATH modifications are handled better via home.sessionPath usually, but keeping some here if tricky
      GOPATH = "${config.home.homeDirectory}/go";
      ANDROID_HOME = "${config.home.homeDirectory}/Android/Sdk";
      NDK_HOME = "${config.home.homeDirectory}/Android/Sdk/ndk/26.3.11579264";
      CARGO_HOME = "${config.home.homeDirectory}/.cargo";
      VISUAL = "nvim";
      EDITOR = "nvim";
      BROWSER = "/usr/bin/google-chrome-stable";
      VCPKG_ROOT = "/opt/vcpkg";
      VCPKG_DOWNLOADS = "/var/cache/vcpkg";
    };

    # Init Content (was initExtra)
    initContent = ''
      # PATH exports
      export PATH=/var/lib/snapd/snap/bin:$PATH
      export PATH=$HOME/.local/bin:$PATH
      export PATH=$HOME/Android/Sdk/platform-tools:$PATH
      export PATH=$HOME/flutter/bin:$PATH
      export PATH=$GOPATH/bin:$PATH
      export CHROME_EXECUTABLE=$(which google-chrome-stable)
      export PATH=$CARGO_HOME/bin:$PATH
      export PATH=$HOME/.bun/bin:$PATH

      export MAKEFLAGS="-j $(nproc --all)"

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

      # Init tools
      eval "$(mcfly init zsh)"
      eval "$(zoxide init zsh)"
      eval "$(starship init zsh)"

      # Broot
      if [ -f $HOME/.config/broot/launcher/bash/br ]; then
        source $HOME/.config/broot/launcher/bash/br
      fi
    '';

    # Sheldon plugins
    plugins = [
      {
        name = "zsh-romaji-complete";
        src = pkgs.fetchFromGitHub {
          owner = "aoyama-val";
          repo = "zsh-romaji-complete";
          rev = "master"; # Pin commit if preferred
          sha256 = "sha256-mgZGOSDFSvOfb8VRvnE58mGGkLj6y1GN12t2q6VDE7g="; # Placeholder, will fail first run if wrong
        };
      }
      {
        name = "ni";
        src = pkgs.fetchFromGitHub {
          owner = "azu";
          repo = "ni.zsh";
          rev = "master"; # Pin commit
          sha256 = "sha256-+yfOKFv4YUuuHm3UWzYTgeZVUjrD22YxFWfuPvMZpzs="; # Placeholder
        };
      }
    ];
  };
}
