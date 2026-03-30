waydroid-loance-and-rotate() {
	waydroid status | grep -q "RUNNING" || waydroid session start
	waydroid show-full-ui
}
