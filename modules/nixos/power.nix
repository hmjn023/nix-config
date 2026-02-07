_:

{
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

      # ThinkPadのバッテリー充電しきい値 (寿命を延ばす)
      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0 = 80;

      # Wake-on-LANを無効化 (勝手な起動を防ぐ)
      WOL_DISABLE = "Y";

      # USB自動サスペンドを一時的に無効化 (トラブルシューティング)
      USB_AUTOSUSPEND = 0;
    };
  };

  # Intel CPUの熱管理ツール
  services.thermald.enable = true;

  # その他の電力管理
  # TLPと競合するため無効化
  powerManagement.powertop.enable = false;
}
