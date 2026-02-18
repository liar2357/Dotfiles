#!/usr/bin/env bash

WALL_ROOT="$HOME/wallpaper"
THEME_FILE="$HOME/.config/hypr/current_theme"

# テーマフォルダ一覧
mapfile -t DIRS < <(find "$WALL_ROOT" -mindepth 1 -maxdepth 1 -type d | sort)

if [ ${#DIRS[@]} -eq 0 ]; then
    echo "テーマディレクトリがありません: $WALL_ROOT"
    exit 1
fi

echo "===== 壁紙テーマ一覧 ====="
for i in "${!DIRS[@]}"; do
    name=$(basename "${DIRS[$i]}")
    printf "  %2d) %s\n" "$((i+1))" "$name"
done
echo "========================="

read -p "番号でテーマを選んでください > " num

# 数字チェック
if ! [[ "$num" =~ ^[0-9]+$ ]]; then
    echo "数字を入力してください。" >&2
    exit 1
fi

index=$((num-1))
if [ "$index" -lt 0 ] || [ "$index" -ge "${#DIRS[@]}" ]; then
    echo "無効な番号です: $num" >&2
    exit 1
fi

# 選んだテーマ名
selected=$(basename "${DIRS[$index]}")

# テーマ保存
mkdir -p "$(dirname "$THEME_FILE")"
echo "$selected" > "$THEME_FILE"

echo "テーマを変更しました → $selected"

exit 0
