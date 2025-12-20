#!/usr/bin/env bash

WALL_ROOT="$HOME/wallpaper"
THEME_FILE="$HOME/.config/hypr/current_theme"
INTERVAL=15

# ─── テーマファイルを確実に作って、ランダムテーマを強制上書き ───

# テーマルート存在チェック
if [ ! -d "$WALL_ROOT" ]; then
    echo "壁紙ルートが存在しません: $WALL_ROOT" >&2
    exit 1
fi

# テーマ候補ディレクトリ一覧
mapfile -t DIRS < <(find "$WALL_ROOT" -mindepth 1 -maxdepth 1 -type d)
if [ ${#DIRS[@]} -eq 0 ]; then
    echo "テーマディレクトリが見つかりません: $WALL_ROOT" >&2
    exit 1
fi

# ランダム選出
RND_THEME="${DIRS[RANDOM % ${#DIRS[@]}]}"
RND_NAME="$(basename "$RND_THEME")"

# テーマファイルを作成 or 上書き
mkdir -p "$(dirname "$THEME_FILE")"
echo "$RND_NAME" > "$THEME_FILE"

# ─── メインループ ───

while true; do
    # ファイルから現在テーマ名を読み込む
    if [ -f "$THEME_FILE" ]; then
        THEME_NAME=$(<"$THEME_FILE")
    else
        sleep "$INTERVAL"
        continue
    fi

    THEME_DIR="$WALL_ROOT/$THEME_NAME"
    # テーマフォルダが無ければ無視
    if [ ! -d "$THEME_DIR" ]; then
        echo "テーマフォルダが存在しません: $THEME_DIR" >&2
        sleep "$INTERVAL"
        continue
    fi

    # テーマ内からランダムに1枚選択
    WALL=$(find "$THEME_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | shuf -n1)

    if [ -n "$WALL" ]; then
        # contain モードで壁紙変更
        hyprctl hyprpaper reload ",contain:$WALL"
    fi

    sleep "$INTERVAL"
done

