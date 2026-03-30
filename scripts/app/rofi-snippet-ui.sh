rofi-snippet-ui() {
	# カテゴリ一覧を作る
	categories=$(ls "$SNIPPET_DIR" | sed 's/\.txt$//')

	# カテゴリ選択
	category=$(printf "%s\n" "$categories" | rofi -dmenu -no-sort -p "select category")

	# 選択が空なら終了
	[ -z "$category" ] && exit 0

	# 実際のファイルパス
	file="$SNIPPET_DIR/${category}.txt"

	# ファイルが存在しなければ終了
	[ ! -f "$file" ] && exit 1

	# カテゴリ内の定型文を選択
	chosen=$(cat "$file" | rofi -dmenu -no-sort -p "Select Snippet ($category)")

	# 選択が空なら終了
	[ -z "$chosen" ] && exit 0

	# クリップボードにコピー
	echo -n "$chosen" | wl-copy

}
