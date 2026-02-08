# 新規ホストのセットアップ手順

このリポジトリに新しい NixOS ホストを追加するための手順です。

## 1. ディレクトリの作成

`hosts/` ディレクトリ配下に新しいホスト名のディレクトリを作成します。

```bash
mkdir -p hosts/<hostname>
```

## 2. ハードウェア設定の生成

ターゲットとなるマシン上で以下のコマンドを実行し、ハードウェア構成ファイルを生成します。

```bash
sudo nixos-generate-config --show-hardware-config > hosts/<hostname>/hardware-configuration.nix
```

※ すでに NixOS がインストールされている場合は、既存の `/etc/nixos/hardware-configuration.nix` をコピーしても構いません。

## 3. ホスト固有設定の作成

### hosts/<hostname>/default.nix
システム全体の設定を記述します。既存のホスト（`hosts/thinkpad/default.nix` など）を参考に作成してください。

```nix
{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/core.nix
    # その他必要なモジュールを追加
  ];

  networking.hostName = "<hostname>";
  
  # ブートローダー、ユーザー設定などを記述
  boot.loader.systemd-boot.enable = true;
  
  system.stateVersion = "25.11"; # インストール時のバージョン
}
```

### hosts/<hostname>/home.nix
Home Manager の設定を記述します。

```nix
{ ... }: {
  imports = [
    ../../modules/home-manager/zsh.nix
    # その他必要なユーザーモジュールを追加
  ];

  home.stateVersion = "25.11";
}
```

## 4. flake.nix への登録

`flake.nix` の `outputs.nixosConfigurations` セクションに新しいホストを追加します。

```nix
nixosConfigurations.<hostname> = nixpkgs.lib.nixosSystem {
  specialArgs = { inherit inputs; };
  modules = [
    ./hosts/<hostname>/default.nix
    { nixpkgs.overlays = [ chaotic.overlays.default ]; }

    home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";
        extraSpecialArgs = { inherit inputs pkgs-latest; };
        users.hmjn = import ./hosts/<hostname>/home.nix;
      };
    }
  ];
};
```

## 5. 設定の適用

新しいホストで設定を適用します。

```bash
sudo nixos-rebuild switch --flake .#<hostname>
```

初回実行時や、新しく作成したファイルが Git で管理されていない場合は、ファイルを `git add` する必要があります（Flake は Git で追跡されていないファイルを無視するため）。

```bash
git add hosts/<hostname>
```

## 6. コードの整形

ファイルをコミットする前に、プロジェクト標準のフォーマッタ（alejandra）を実行してください。

```bash
nix fmt
```

## 7. セットアップ環境（ライブメディア）でのツール利用

NixOS のライブ環境で git やエディタなどのツールが必要な場合、以下の方法が効率的です。

### 一時的なツールの利用 (`nix shell`)
パッケージをインストールすることなく、その場ですぐにツールを利用できます。

```bash
# git と vim を一時的に利用する
nix shell nixpkgs#git nixpkgs#vim
```

### プロジェクトの開発環境を利用 (`nix develop`)
このリポジトリの `flake.nix` に定義されている開発用シェルをロードします。

```bash
# 通常の開発（コード整形など）
nix develop

# 新規ホストのセットアップ（f2fs ツールやエイリアスを含む）
nix develop .#setup
```

### f2fs 便利エイリアス
`nix develop .#setup` で起動したシェルでは、このプロジェクト標準の f2fs オプションが適用されたエイリアスが利用可能です。

- `format-f2fs <device>`: 圧縮やチェックサムを有効にしてフォーマットします。
- `mount-f2fs <device> <mount_point>`: 標準のマウントオプションでマウントします。

### (上級者向け) カスタム ISO の作成
自分の SSH 鍵やよく使うツールをプリインストールした ISO を作成することも可能です。必要に応じて `flake.nix` に `nixos-generators` を追加することで、自分の設定を反映したインストーラをビルドできます。
