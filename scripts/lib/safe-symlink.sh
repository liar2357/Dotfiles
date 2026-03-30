source $HOME/Dotfiles/scripts/lib/log.sh

safe-symlink() {
	local src="$1"
	local dst="$2"

	log "start: src=$src dst=$dst"

	# 引数チェック
	if [ -z "$src" ] || [ -z "$dst" ]; then
		log_error "Usage: safe_ln <source> <destination>"
		return 1
	fi

	# src存在チェック
	if [ ! -e "$src" ]; then
		log_error "source not found: $src"
		return 1
	fi

	# 親ディレクトリ作成
	local parent
	parent="$(dirname "$dst")"

	if [ ! -d "$parent" ]; then
		log "mkdir: $parent"
		mkdir -p "$parent" || {
			log_error "failed to create directory: $parent"
			return 1
		}
	fi

	# 既存ファイル退避
	if [ -e "$dst" ] || [ -L "$dst" ]; then
		local timestamp
		timestamp=$(date +%Y%m%d%H%M%S)
		local backup="${dst}-${timestamp}"

		log "backup: $dst -> $backup"
		mv "$dst" "$backup"
	fi

	# シンボリックリンク作成
	ln -s "$src" "$dst"
	if [ $? -eq 0 ]; then
		log "linked: $src -> $dst"
	else
		log_error "failed to link: $src -> $dst"
		return 1
	fi

	log "done"
}
