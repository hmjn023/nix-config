{ config, pkgs, inputs, ... }:

let
  # Simple wrapper to run anything with ZZZ's Proton prefix
  zzz-run = pkgs.writeShellScriptBin "zzz-run" ''
    export STEAM_COMPAT_DATA_PATH="$HOME/.local/share/zzz-proton"
    export STEAM_COMPAT_CLIENT_INSTALL_PATH="$HOME/.steam/steam"
    
    mkdir -p "$STEAM_COMPAT_DATA_PATH"
    
    exec ${inputs.chaotic.packages.${pkgs.system}.proton-cachyos}/bin/proton run "$@"
  '';
in
{
  home.packages = [ zzz-run ];
}