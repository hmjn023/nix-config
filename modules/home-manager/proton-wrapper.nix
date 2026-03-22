{pkgs, ...}: let
  # Native wrapper for CachyOS/Arch
  # This uses the system's libraries instead of Nix's steam-run FHS environment.
  zzz-run = pkgs.writeShellScriptBin "zzz-run" ''
    export STEAM_COMPAT_DATA_PATH="$HOME/.local/share/zzz-proton"
    export STEAM_COMPAT_CLIENT_INSTALL_PATH="$HOME/.steam/steam"

    # Improve controller detection for Proton/SDL
    export SDL_JOYSTICK_HIDAPI=1
    export SDL_GAMECONTROLLER_USE_BUTTON_LABELS=1

    # Force evdev driver (often more reliable than hidraw on some setups)
    export SDL_JOYSTICK_DRIVER=evdev
    # Force X11 video driver (avoids Wayland input grabbing issues)
    export SDL_VIDEODRIVER=x11

    mkdir -p "$STEAM_COMPAT_DATA_PATH"

    # Find proton binary (prefer system installed proton-cachyos)
    PROTON_BIN=$(command -v proton || command -v proton-cachyos || echo "")

    if [ -z "$PROTON_BIN" ]; then
      echo "Error: Proton binary not found in PATH. Please install 'proton-cachyos' via pacman."
      exit 1
    fi

    echo "Using Proton: $PROTON_BIN"
    exec "$PROTON_BIN" run "$@"
  '';
in {
  home.packages = [zzz-run];
}
