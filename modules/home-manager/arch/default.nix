{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.my.arch;
in {
  options.my.arch = {
    packages = mkOption {
      type = types.listOf types.str;
      default = [];
      description = "List of Arch Linux packages to sync via paru";
    };
  };

  # Activation script moved to mise for better stability and interactivity
  config = {};
}
