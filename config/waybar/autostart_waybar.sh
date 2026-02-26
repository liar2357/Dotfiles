#!/usr/bin/env bash

HOSTNAME=$(hostnamectl --static)

CONFIG_TOP="$HOME/.config/waybar/conf/top_$HOSTNAME.jsonc"
CONFIG_BOTTOM="$HOME/.config/waybar/conf/bottom_$HOSTNAME.jsonc"

STYLE="$HOME/.config/waybar/styles/style_$HOSTNAME.css"

WATCH_DIR="$HOME/Dotfiles/config/waybar"

notify() {
	notify-send "Waybar Reload" "$1"
}

kill_waybar() {
	pkill -x waybar
}

start_waybars() {
	waybar -c "$CONFIG_TOP" -s "$STYLE" &
	WAYBAR_TOP_PID=$!

	waybar -c "$CONFIG_BOTTOM" -s "$STYLE" &
	WAYBAR_BOTTOM_PID=$!
}

reload_waybars() {
	kill_waybar
	start_waybars
	notify "Reloaded"
}

watch_configs() {
	inotifywait -m -r -e modify,close_write,create,delete,move "$WATCH_DIR" |
		while read -r; do
			reload_waybars
		done
}

start_waybars
notify "Started"

watch_configs
