hyprland-toggle-rotete() {
	# --- 横画面 ---
	apply_landscape() {
		hyprctl keyword monitor "$MONITOR,preferred,auto,1,transform,0"
		sleep 0.1

		hyprctl keyword input:touchdevice:transform 0
		hyprctl keyword input:tablet:transform 0
		hyprctl keyword input:touchdevice:output "$MONITOR"
		hyprctl keyword input:tablet:output "$MONITOR"

	}

	# --- 縦画面 ---
	apply_portrait() {
		hyprctl keyword monitor "$MONITOR,preferred,auto,1,transform,3"
		sleep 0.1

		hyprctl keyword input:touchdevice:transform 3
		hyprctl keyword input:tablet:transform 3
		hyprctl keyword input:touchdevice:output "$MONITOR"
		hyprctl keyword input:tablet:output "$MONITOR"

	}

	# --- メイン処理 ---
	mkdir -p "$(dirname "$LOCK")"

	if [ -f "$LOCK" ]; then
		apply_landscape
		rm "$LOCK"
	else
		apply_portrait
		touch "$LOCK"
	fi
}
