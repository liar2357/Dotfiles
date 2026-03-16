#!/usr/bin/env bash

pgrep -f autostart_waybar.sh | grep -v $$ >/dev/null && exit

HOSTNAME=$(hostnamectl --static)

CONFIG_TOP="$HOME/.config/waybar/conf/top_$HOSTNAME.jsonc"
CONFIG_BOTTOM="$HOME/.config/waybar/conf/bottom_$HOSTNAME.jsonc"

STYLE="$HOME/.config/waybar/styles/style_$HOSTNAME.css"

WATCH_DIR="$HOME/Dotfiles/config/waybar"

notify() {
	notify-send "Waybar Reload" "$1"
}

kill_waybar() {

	[ -n "$WAYBAR_TOP_PID" ] && kill "$WAYBAR_TOP_PID" 2>/dev/null
	[ -n "$WAYBAR_BOTTOM_PID" ] && kill "$WAYBAR_BOTTOM_PID" 2>/dev/null

	wait "$WAYBAR_TOP_PID" 2>/dev/null
	wait "$WAYBAR_BOTTOM_PID" 2>/dev/null
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
	inotifywait -m -r -e close_write,create,delete,move "$WATCH_DIR" |
		while read -r path event file; do
			reload_waybars

			# debounce
			timeout 1 cat >/dev/null
		done
	}

start_waybars
notify "Started"

watch_configs
