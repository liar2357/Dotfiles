hyprland-toggle-rotete() {
	# --- 横画面 ---
	apply_landscape() {
		hyprctl eval "hl.monitor({
			output = '$MONITOR',
			mode = 'preferred',
			position = 'auto',
			scale = 1,
			transform = 0,
		})"

		hyprctl eval "hl.config({
			['input.touchdevice.transform'] = 0,
			['input.touchdevice.output'] = '$MONITOR',
			['input.tablet.transform'] = 0,
			['input.tablet.output'] = '$MONITOR',
		})"
	}

	# --- 縦画面 ---
	apply_portrait() {
		hyprctl eval "hl.monitor({
			output = '$MONITOR',
			mode = 'preferred',
			position = 'auto',
			scale = 1,
			transform = 3,
		})"

		hyprctl eval "hl.config({
			['input.touchdevice.transform'] = 3,
			['input.touchdevice.output'] = '$MONITOR',
			['input.tablet.transform'] = 3,
			['input.tablet.output'] = '$MONITOR',
		})"
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
