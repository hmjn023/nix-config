{ pkgs, ... }:

{
  hardware.graphics = {
    extraPackages = with pkgs; [
      intel-media-driver
      intel-compute-runtime
      intel-compute-runtime.drivers
      intel-graphics-compiler
      intel-npu-driver
      level-zero
      vpl-gpu-rt
      oneDNN_2
    ];
  };

  boot.kernel.sysctl = {
    "dev.i915.perf_stream_paranoid" = 0;
  };

  # Intel GPU environment variables
  environment.variables = {
    SYCL_CACHE_PERSISTENT = "1";
    LIBVA_DRIVER_NAME = "iHD";
  };

  programs.nix-ld.libraries = with pkgs; [
    # Intel GPU and NPU support
    level-zero
    intel-compute-runtime
    intel-media-driver
    intel-npu-driver
    oneDNN_2
  ];
}
