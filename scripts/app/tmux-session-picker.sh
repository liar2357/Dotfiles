#!/usr/bin/env bash

tmpfile="$HOME/script-lock/tmux-session-target"

mkdir -p "$(dirname "$tmpfile")"
rm -f "$tmpfile"

target=$(
	tmux list-sessions -F "#{session_name}" 2>/dev/null |
		fzf --reverse \
			--prompt="session> " \
			--print-query \
			--preview="tmux capture-pane -ep -t {} -S -100" \
			--preview-window=down:60% \
			--border |
		{
			read query
			read choice
			echo "${choice:-$query}"
		}
)

[ -z "$target" ] && exit 0

echo "$target" >"$tmpfile"
