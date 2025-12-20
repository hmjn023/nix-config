{ config, pkgs, ... }:

{
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
      
      # Key settings (translated from keys.zsh)
      bindkey "^[[1~" beginning-of-line
      bindkey "^[[4~" end-of-line
      bindkey "^[[2~" overwrite-mode
      bindkey "^?" backward-delete-char
      bindkey "^[[3~" delete-char
      bindkey "^[[A" up-line-or-history
      bindkey "^[[B" down-line-or-history
      bindkey "^[[D" backward-char
      bindkey "^[[C" forward-char
      bindkey "^[[5~" beginning-of-buffer-or-history
      bindkey "^[[6~" end-of-buffer-or-history
      bindkey "^[[Z" reverse-menu-complete
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
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.7.0";
          sha256 = "sha256-KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
        };
      }
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
