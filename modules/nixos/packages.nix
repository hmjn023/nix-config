{pkgs, ...}: {
  # System-wide Packages
  environment.systemPackages = with pkgs; [
    # Core
    neovim
    git
    wget
    curl
    usbutils
    v4l-utils
    tree

    # CLI Tools
    f2fs-tools
    xdg-utils
    lsd
    starship
    zoxide
    mcfly
    bat
    ripgrep
    fd
    jq
    viu
    kakasi
    tree-sitter
    dua
    ouch
    gh
    yt-dlp
    nodejs_24
    bun

    # Dev
    gcc
    gnumake
    python3
    uv
    clinfo
    vulkan-tools

    # KDE Tools
    kdePackages.systemsettings
    kdePackages.kde-cli-tools
    kdePackages.plasma-pa # Audio settings
    kdePackages.bluedevil # Bluetooth settings
    kdePackages.bluez-qt # Bluetooth QML module
    kdePackages.kirigami-addons
    kdePackages.qqc2-desktop-style
  ];
}
