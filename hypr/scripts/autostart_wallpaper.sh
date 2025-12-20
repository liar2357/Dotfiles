#!/usr/bin/env bash

# まず Hyprpaper を安全に起動
hyprpaper &

# Hyprpaper がソケット待ちになるまで少し待つ（待ち長さは微調整可）
sleep 1

# メイン壁紙スクリプトを起動
~/.config/hypr/scripts/rand.sh &
