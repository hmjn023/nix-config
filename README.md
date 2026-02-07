# NixOS 設定

このリポジトリには、Nix Flakes と Home Manager を使用して管理されている個人の NixOS 設定が含まれています。複数のホストをサポートし、モジュール化された構造を採用しています。

## ホスト構成

現在、以下のホスト設定が定義されています：

- `thinkpad`: Lenovo ThinkPad (メインのノートPC)
- `desk-dell`: Dell デスクトップ

## 使い方

### 設定の適用 (システム切り替え)

現在のシステムに設定を適用するには、以下のコマンドを実行します：

```bash
# thinkpad の場合
sudo nixos-rebuild switch --flake .#thinkpad

# desk-dell の場合
sudo nixos-rebuild switch --flake .#desk-dell

# ホスト名が一致している場合は単に：
sudo nixos-rebuild switch --flake .
```

### システムの更新 (チャネルの更新)

Flake の入力（チャネル）を最新バージョンに更新するには：

```bash
nix flake update
```

更新後、上記の `switch` コマンドを再度実行して変更を適用してください。

### コードの整形 (フォーマット)

このプロジェクトでは、Nix ファイルの整形に `alejandra` を使用しています。全コードを整形するには：

```bash
nix fmt
```

### 静的解析 (Lint) とチェック

`statix` や `deadnix` を使用したコード品質チェックが含まれています。これらを実行するには：

```bash
nix flake check
```

## ディレクトリ構造

- `hosts/`: マシン固有の設定。
- `modules/nixos/`: システムレベルのモジュール。
- `modules/home-manager/`: Home Manager で管理されるユーザーレベルのモジュール。
- `flake.nix`: 設定のエントリポイント。