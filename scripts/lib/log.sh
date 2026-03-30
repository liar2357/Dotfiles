# ログ関数
log() {
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] INFO: $*"
}

log_error() {
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] ERROR: $*" >&2
}
