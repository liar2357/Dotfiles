#!/usr/bin/env bash

LOCK="$HOME/.script_lock/screen_rotate"
MONITOR="eDP-1" # ← hyprctl monitors で確認して変更

if [ -f "$LOCK" ]; then
	# 横
	hyprctl keyword monitor "$MONITOR,preferred,auto,1,transform,0"

	hyprctl keyword input:touchdevice:transform 0
	hyprctl keyword input:tablet:transform 0

	hyprctl keyword input:touchdevice:output "$MONITOR"
	hyprctl keyword input:tablet:output "$MONITOR"

	rm "$LOCK"
else
	# 縦（270°）
	hyprctl keyword monitor "$MONITOR,preferred,auto,1,transform,3"

	hyprctl keyword input:touchdevice:transform 3
	hyprctl keyword input:tablet:transform 3

	hyprctl keyword input:touchdevice:output "$MONITOR"
	hyprctl keyword input:tablet:output "$MONITOR"

	touch "$LOCK"
fi
