#!/usr/bin/env bash

WALL_ROOT="$HOME/wallpaper"
THEME_FILE="$HOME/.config/hypr/current_theme"
INTERVAL=15

# ── 起動時：必ずランダムテーマを決定 ──────────────────

mapfile -t THEMES < <(find "$WALL_ROOT" -mindepth 1 -maxdepth 1 -type d | sort)
[ ${#THEMES[@]} -eq 0 ] && exit 1

RND_THEME="$(basename "${THEMES[RANDOM % ${#THEMES[@]}]}")"

mkdir -p "$(dirname "$THEME_FILE")"
echo "$RND_THEME" >"$THEME_FILE"

echo "起動時テーマ: $RND_THEME"

# ── メインループ ───────────────────────────────────────

while true; do
	THEME="$(<"$THEME_FILE")"
	THEME_DIR="$WALL_ROOT/$THEME"

	[ ! -d "$THEME_DIR" ] && sleep "$INTERVAL" && continue

	# モニター一覧
	mapfile -t MONITORS < <(hyprctl monitors -j | jq -r '.[].name')
	[ ${#MONITORS[@]} -eq 0 ] && sleep "$INTERVAL" && continue

	# 画像一覧
	mapfile -t IMAGES < <(
		find "$THEME_DIR" -type f \
			\( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) |
			shuf
	)
	[ ${#IMAGES[@]} -eq 0 ] && sleep "$INTERVAL" && continue

	# いったん全部 unload
	hyprctl hyprpaper unload all >/dev/null 2>&1

	# モニターごとに割り当て
	for i in "${!MONITORS[@]}"; do
		MON="${MONITORS[$i]}"
		IMG="${IMAGES[$((i % ${#IMAGES[@]}))]}"

		hyprctl hyprpaper preload "$IMG"
		hyprctl hyprpaper wallpaper "$MON,$IMG,contain"
	done

	sleep "$INTERVAL"
done
