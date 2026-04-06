{pkgs, ...}: let
  # Native wrapper for CachyOS/Arch
  # This uses the system's libraries instead of Nix's steam-run FHS environment.
  protonShim = pkgs.writeShellScriptBin "proton-cachyos" ''
    if [ "$1" = "run" ]; then
      shift
    fi

    export WINEPREFIX="$HOME/.local/share/zzz-proton"
    export STEAM_COMPAT_DATA_PATH="$WINEPREFIX"
    export STEAM_COMPAT_CLIENT_INSTALL_PATH="$HOME/.steam/steam"
    export GAMEID="umu-zzz"

    # Improve controller detection for Proton/SDL
    export SDL_JOYSTICK_HIDAPI=1
    export SDL_GAMECONTROLLER_USE_BUTTON_LABELS=1

    # Force evdev driver (often more reliable than hidraw on some setups)
    export SDL_JOYSTICK_DRIVER=evdev
    # Force X11 video driver (avoids Wayland input grabbing issues)
    export SDL_VIDEODRIVER=x11

    mkdir -p "$WINEPREFIX"

    if command -v umu-run >/dev/null 2>&1; then
      for candidate in \
        "$HOME/.local/share/Steam/compatibilitytools.d/proton-cachyos-slr" \
        "$HOME/.steam/root/compatibilitytools.d/proton-cachyos-slr" \
        "/usr/share/steam/compatibilitytools.d/proton-cachyos-slr" \
        "/usr/share/steam/compatibilitytools.d/proton-cachyos"
      do
        if [ -d "$candidate" ]; then
          export PROTONPATH="$candidate"
          echo "Using Proton via umu-run: $PROTONPATH"
          exec umu-run "$@"
        fi
      done
    fi

    PROTON_BIN=$(command -v proton || command -v proton-cachyos-bin || echo "")

    if [ -z "$PROTON_BIN" ]; then
      echo "Error: No usable Proton runtime found."
      echo "Install 'umu-launcher' and a compatibility tool such as 'proton-cachyos-slr',"
      echo "or install a package that exposes a direct Proton executable."
      exit 1
    fi

    echo "Using Proton: $PROTON_BIN"
    exec "$PROTON_BIN" run "$@"
  '';

  zzz-run = pkgs.writeShellScriptBin "zzz-run" ''
    exec ${protonShim}/bin/proton-cachyos "$@"
  '';
in {
  home.packages = [protonShim zzz-run];
}
