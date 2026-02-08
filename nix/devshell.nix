{
  pkgs,
  pre-commit-check,
  compressExtensions,
  ...
}: let
  baseOpts = [
    "compress_algorithm=zstd:6"
    "compress_chksum"
    "atgc"
    "gc_merge"
    "lazytime"
  ];
  extensionOpts = map (ext: "compress_extension=${ext}") compressExtensions;
  compressOpts = pkgs.lib.concatStringsSep "," (baseOpts ++ extensionOpts);
in {
  # Standard development shell
  default = pkgs.mkShell {
    inherit (pre-commit-check) shellHook;
    buildInputs = pre-commit-check.enabledPackages;
  };

  # Special shell for setting up new hosts
  setup = pkgs.mkShell {
    buildInputs =
      pre-commit-check.enabledPackages
      ++ (with pkgs; [
        f2fs-tools
        git
        vim
      ]);

    shellHook = ''
      ${pre-commit-check.shellHook}
      alias format-f2fs="sudo mkfs.f2fs -O extra_attr,inode_checksum,sb_checksum,compression"
      alias mount-f2fs="sudo mount -t f2fs -o ${compressOpts}"
      echo "--- F2FS Setup Environment ---"
      echo "Available helpers: format-f2fs, mount-f2fs"
      echo "Compressed extensions: ${pkgs.lib.concatStringsSep ", " compressExtensions}"
    '';
  };
}
