#!/usr/bin/env bash

# 直近の履歴を取得して fzf に渡す
# 必要に応じて --since オプションで期間制限可能
notilogctl get --tail 300 |
	fzf --ansi \
		--prompt="Notifications> " \
		--preview="echo {} | awk -F '|' '{printf \"App: %s\nTitle: %s\nBody:\n%s\nTime: %s\n\", \$1, \$2, \$3, \$4}'" \
		--preview-window=right:60%:wrap
