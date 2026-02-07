{
  pkgs,
  lib,
  ...
}: {
  virtualisation.waydroid.enable = true;

  environment.systemPackages = with pkgs; [
    (
      let
        # Python Environment with dependencies required by waydroid_script
        myPython = python3.withPackages (ps:
          with ps; [
            requests
            tqdm
            inquirerpy
          ]);
      in
        writeShellScriptBin "waydroid-script" ''
          # Directory to store the script
          WORKDIR="/var/lib/waydroid-script"

          echo "Setting up waydroid_script environment..."

          # Ensure the directory exists
          if [ ! -d "$WORKDIR" ]; then
            echo "Cloning waydroid_script repository..."
            ${git}/bin/git clone https://github.com/casualsnek/waydroid_script "$WORKDIR"
          else
            echo "Updating waydroid_script repository..."
            cd "$WORKDIR" && ${git}/bin/git pull
          fi

          # Prepare dependencies path
          export PATH="${lib.makeBinPath [git lzip sqlite which]}:$PATH"

          echo "Running waydroid_script..."
          cd "$WORKDIR"

          # Run the script using the prepared Python environment
          # We use sudo automatically if not running as root, because waydroid setup requires it.
          if [ "$EUID" -ne 0 ]; then
            echo "Root privileges are required for Waydroid setup."
            sudo env PATH="$PATH" ${myPython}/bin/python3 main.py "$@"
          else
            ${myPython}/bin/python3 main.py "$@"
          fi
        ''
    )
  ];
}
