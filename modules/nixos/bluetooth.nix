{ pkgs, ... }:

{
  # Bluetoothの有効化
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  # Blueman (Bluetoothマネージャー) の有効化
  services.blueman.enable = true;

  # コントローラー対応
  # Steam Hardwareのudevルールを有効化（Steam以外のゲームでもコントローラーが認識されやすくなります）
  hardware.steam-hardware.enable = true;

  # 必要に応じて追加のドライバパッケージをインストール
  environment.systemPackages = with pkgs; [
    bluez
    bluez-tools
  ];
}
