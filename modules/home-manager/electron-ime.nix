{...}: let
  flags = ''
    --enable-features=UseOzonePlatform
    --ozone-platform=wayland
    --enable-wayland-ime
  '';
in {
  xdg.configFile."discord-flags.conf".text = flags;
  xdg.configFile."vesktop-flags.conf".text = flags;
}
