_: {
  # 電力管理サービスの有効化
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 100;

      # ThinkPadのバッテリー充電しきい値
      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0 = 80;

      # Wake-on-LANを無効化
      WOL_DISABLE = "Y";

      # PCI Expressの省電力設定 (重要: スリープ中の電力削減に寄与)
      PCIE_ASPM_ON_AC = "default";
      PCIE_ASPM_ON_BAT = "powersupersave";

      # プラットフォームプロファイル (対応機種の場合)
      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "low-power";

      # Intel P-State 設定
      INTEL_PSTATE_ON_AC = "performance";
      INTEL_PSTATE_ON_BAT = "powersave";

      # ディスクの省電力設定
      SATA_LINKPWR_ON_AC = "med_power_with_dipm";
      SATA_LINKPWR_ON_BAT = "min_power";

      # USB自動サスペンドの有効化
      USB_AUTOSUSPEND = 1;
    };
  };

  # Intel CPUの熱管理ツール
  services.thermald.enable = true;

  # その他の電力管理
  # TLPと競合するため無効化
  powerManagement.powertop.enable = false;
}
