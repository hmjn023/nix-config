# NixOS 設定 (Home Manager 移行中)

> [!IMPORTANT]
> **現在 NixOS から卒業し、Arch Linux (CachyOS) 上で Home Manager を使用する構成へ移行中です。**
> システム全体（NixOS）の管理から、ユーザー環境（Home Manager）のみの管理へとシフトしています。

このリポジトリには、Nix Flakes と Home Manager を使用して管理されている個人の設定が含まれています。

## ホスト構成

現在、以下のホスト設定が定義されています：

- `thinkpad`: Lenovo ThinkPad (メインのノートPC - Arch Linux + Home Manager)
- `desk-dell`: Dell デスクトップ (移行中)

## 使い方

### 設定の適用 (Home Manager)

現在のユーザー環境に設定を適用するには、以下のコマンドを実行します：

```bash
# flake を適用
home-manager switch --flake .
```

### システムの更新 (Flake)

Flake の入力（lockファイル）を最新バージョンに更新するには：

```bash
nix flake update
```

更新後、上記の `switch` コマンドを再度実行して変更を適用してください。

### コードの整形 (フォーマット)

このプロジェクトでは、Nix ファイルの整形に `alejandra` を使用しています。全コードを整形するには：

```bash
nix fmt
```

## ディレクトリ構造

- `hosts/`: マシン固有の設定（`home.nix` がメイン）。
- `modules/home-manager/`: Home Manager で管理されるユーザーレベルのモジュール。
- `modules/nixos/`: (旧) システムレベルのモジュール。
- `flake.nix`: 設定のエントリポイント。
