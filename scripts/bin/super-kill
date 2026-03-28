#!/usr/bin/env bash

# ランチャー系まとめて処理
for app in fuzzel rofi wofi; do
	if pgrep -f "$app" >/dev/null; then
		pgrep -f "$app" | xargs -r kill
		exit
	fi
done

# フルスクリーン解除
if hyprctl activewindow | grep -q "fullscreen: 1"; then
	hyprctl dispatch fullscreen 0
	exit
fi

# 通常ウィンドウkill
hyprctl dispatch killactive
