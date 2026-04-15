#!/usr/bin/env bash

target="$1"

[ -z "$target" ] && exit 1

tmux new-session -Ad -s "$target"
tmux switch-client -t "$target"
