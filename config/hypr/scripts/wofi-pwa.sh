#!/usr/bin/env bash

# PWA の .desktop ファイル一覧
desktop_files=$(grep -l -- '--app-id=' ~/.local/share/applications/vivaldi-*.desktop)

# 表示する行を作る
# Name= を抜き出してラベルにする
choices=""
declare -A MAP

for file in $desktop_files; do
	# アプリ名（Name=）
	name=$(grep '^Name=' "$file" | head -n1 | cut -d'=' -f2-)
	# デスクトップID（gtk-launch で起動に使う）
	id=$(basename "$file" .desktop)
	# マッピングに追加
	MAP["$name"]="$id"
	# リスト行を作成
	choices="${choices}${name}\n"
done

# wofi に一覧を流す
selected=$(printf "%b" "$choices" | wofi --dmenu --prompt "PWA: ")

# 選択が空じゃなければ起動
if [[ -n "$selected" ]]; then
	gtk-launch "${MAP[$selected]}"
fi
