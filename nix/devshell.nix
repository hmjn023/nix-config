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
    env = {
      NIX_LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath (with pkgs; [
        stdenv.cc.cc.lib
        zlib
        glibc
        libGL
        libxkbcommon
        wayland
        xorg.libX11
      ]);
      NIX_LD = pkgs.lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker";
    };
    shellHook = ''
      ${pre-commit-check.shellHook}
      export NIX_LD_LIBRARY_PATH="$NIX_LD_LIBRARY_PATH"
      export NIX_LD="$NIX_LD"
      echo "--- Development Environment with nix-ld ---"
      echo "NIX_LD_LIBRARY_PATH is set to find libstdc++.so.6"
    '';
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
