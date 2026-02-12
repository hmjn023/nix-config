{
  config,
  pkgs,
  ...
}: {
  # NVIDIA drivers
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true; # Open Kernel Modules を有効にする
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
    ];
  };

  environment.systemPackages = with pkgs; [
    cudaPackages_13.cudatoolkit
    cudaPackages_13.cudnn
    cudaPackages_13.libcusparse_lt
    cudaPackages_13.nccl
    cudaPackages_13.libnvshmem
    cudaPackages_13.libcublas
    cudaPackages_13.libcufft
    cudaPackages_13.libcurand
    cudaPackages_13.libcusolver
    cudaPackages_13.libcusparse
    nvtopPackages.nvidia
    pciutils
    nvidia-vaapi-driver
  ];

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    XDG_SESSION_TYPE = "wayland";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = "1";
    MOZ_DISABLE_RDD_SANDBOX = "1";
    NVD_BACKEND = "direct";
    # Fix for screen sharing freezing
    UE_ENABLE_WD_WORKAROUND = "1";

    # Electron flags for hardware access
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    NIXOS_OZONE_WL = "1";

    # CUDA environment variables
    CUDA_PATH = "${pkgs.cudaPackages_13.cudatoolkit}";
    LD_LIBRARY_PATH = let
      cudaLibs = with pkgs.cudaPackages_13; [
        cudatoolkit
        cudnn.lib
        libcusparse_lt
        nccl
        libnvshmem
        libcublas
        libcufft
        libcurand
        libcusolver
        libcusparse
      ];
    in "/run/opengl-driver/lib:${config.hardware.nvidia.package}/lib:" + (pkgs.lib.makeLibraryPath cudaLibs);
  };

  programs.nix-ld.libraries = with pkgs.cudaPackages_13; [
    cudatoolkit
    cudnn.lib
    libcusparse_lt
    nccl
    libnvshmem
    libcublas
    libcufft
    libcurand
    libcusolver
    libcusparse
  ];
}
