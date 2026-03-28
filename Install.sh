#!/usr/bin/env bash

set -e

DOTFILES="$HOME/Dotfiles"

# glob未一致対策（重要）
shopt -s nullglob dotglob

echo "Linking .config..."

mkdir -p "$HOME/.config"

for dir in "$DOTFILES/config"/*; do
	name=$(basename "$dir")
	target="$HOME/.config/$name"

	if [ ! -e "$target" ]; then
		ln -s "$dir" "$target"
		echo "linked: ~/.config/$name"
	else
		echo "skip: ~/.config/$name exists"
	fi
done

echo "Linking home..."

for dir in "$DOTFILES/home"/*; do
	name=$(basename "$dir")
	target="$HOME/$name"

	if [ ! -e "$target" ]; then
		ln -s "$dir" "$target"
		echo "linked: ~/$name"
	else
		echo "skip: ~/$name exists"
	fi
done

echo "Done."
