# Dotfiles

> [English](README.md)

Linux環境向けの個人用ドットファイル・設定ファイルリポジトリです。

## 概要

このリポジトリは、Linux環境での開発環境やシステム設定を一元管理するための設定ファイル集です。Nix Flakeとして利用することも、スクリプトでシンボリックリンクを貼って利用することもできます。

## ディレクトリ構成

```
.
├── config/          # ~/.config 配下に配置すべき各ツールの設定
│                    # hypr, nvim, その他の設定ファイルを含む
├── shell/           # シェル環境設定 (zsh, pwsh)
├── scripts/         # 自作スクリプト
├── hosts/           # ホスト名別の環境固有設定
├── nix/             # Nix Flakeおよび NixOS 設定 (HomeManager含む)
├── tmux/            # tmux の設定
├── packages/        # パッケージ管理関連の設定
├── share/           # 共有リソース
├── notes/           # ドキュメント・ノート
├── flake.nix        # Nix Flake定義
└── Install.sh       # Linux用インストールスクリプト
```

## インストール方法

### 方法1: シェルスクリプトを使用（Linux/macOS）

最もシンプルな方法として、シンボリックリンクを自動で貼るインストールスクリプトを提供しています：

```bash
git clone https://github.com/liar2357/Dotfiles.git ~/.dotfiles
cd ~/.dotfiles
chmod +x Install.sh
./Install.sh
```

`Install.sh` は、`config` ディレクトリ内の設定ファイルを `~/.config` 配下にシンボリックリンクして使用します。

### 方法2: Nix Flakeを使用（NixOS推奨）

NixOS環境またはNix Flakeをサポートする環境では、Home Managerを利用した設定が可能です：

```bash
git clone https://github.com/liar2357/Dotfiles.git ~/.dotfiles
cd ~/.dotfiles
nix flake update  # (オプション) Flakeロックファイルを更新
nix flake show    # 利用可能な設定を確認
```

詳細は `nix/` ディレクトリ内のHome Manager設定を参照してください。

### 方法3: Windows用 PowerShell スクリプト（限定的なサポート）

一部の設定のみですが、`Install-win.ps1` で Windows 環境への部分的な導入が可能です。

## 重要な注意事項

### 個人環境に最適化された設定について

`hosts/` ディレクトリと `nix/` ディレクトリ内の設定は、作成者の個人的な運用環境に最適化されています。これらをそのまま使用する際は：

- **参考として利用する** か
- **クローン後に自分の環境に合わせて書き換える** ことを強く推奨します

特にホスト名別設定や NixOS の system 設定は、あなたのマシンに直接適用すると問題が生じる可能性があります。

### スクリプトの依存関係

`scripts/` ディレクトリ内の自作スクリプトは、それぞれが特定のコマンドやパッケージに依存しています（例：`ffmpeg`, `imagemagick` など）。

スクリプトを使用する前に、以下の点をご確認ください：

- スクリプト内の先頭コメントまたはヘッダーで依存パッケージを確認
- 必要なツールをあらかじめインストール
- スクリプトが自分の環境で正常に動作するかテスト

## サポートされるツール

`config/` ディレクトリに含まれる主な設定例：

- **Hyprland** - Waylandウィンドウマネージャー
- **Neovim** - テキストエディタ設定
- その他多数のCLIツールおよびアプリケーション

各ツールの詳細な設定は、`config/` ディレクトリ内のディレクトリ名から確認できます。

## セットアップ後

インストール後、必要に応じて以下を確認してください：

1. シンボリックリンクが正しく貼られたか確認
2. 各設定ファイルがツールから正しく読み込まれているか確認
3. `shell/` ディレクトリの設定が自分の `.bashrc`, `.zshrc` などに読み込まれているか確認

## トラブルシューティング

設定が反映されない場合は：

- シンボリックリンク先が正しいか確認：`ls -la ~/.config`
- ツール側の設定パスが変更されていないか確認
- 環境変数やシェル設定が干渉していないか確認

## ライセンス

このリポジトリはライセンスフリー、または自由に使用可能です。詳細はリポジトリの LICENSE ファイルを参照してください。

## 参考資料

- [Nix Flakes Documentation](https://nixos.wiki/wiki/Flakes)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Hyprland Documentation](https://hyprland.org/)

---

質問や問題がある場合は、このリポジトリの Issues で報告してください。
