{ config, pkgs, inputs, ... }:

let
  # Wrapper to run Proton inside steam-run environment to fix library issues (FreeType etc.)
  zzz-run = pkgs.writeShellScriptBin "zzz-run" ''
    export STEAM_COMPAT_DATA_PATH="$HOME/.local/share/zzz-proton"
    export STEAM_COMPAT_CLIENT_INSTALL_PATH="$HOME/.steam/steam"
    
    mkdir -p "$STEAM_COMPAT_DATA_PATH"
    
    # Use steam-run to provide FHS environment with necessary libs
    exec ${pkgs.steam-run}/bin/steam-run ${inputs.chaotic.packages.${pkgs.system}.proton-cachyos}/bin/proton run "$@"
  '';
in
{
  home.packages = [ zzz-run ];
}
