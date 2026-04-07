#!/usr/bin/env bash

source $HOME/Dotfiles/scripts/lib/safe-symlink.sh
HOSTNAME=$(hostname)

#-- .config --
safe-symlink "$HOME/Dotfiles/config/fuzzel" "$HOME/.config/fuzzel"
safe-symlink "$HOME/Dotfiles/config/kitty" "$HOME/.config/kitty"
safe-symlink "$HOME/Dotfiles/config/wezterm" "$HOME/.config/wezterm"
safe-symlink "$HOME/Dotfiles/config/nvim" "$HOME/.config/nvim"
safe-symlink "$HOME/Dotfiles/config/nvim-lite" "$HOME/.config/nvim-lite"
safe-symlink "$HOME/Dotfiles/config/ranger" "$HOME/.config/ranger"
safe-symlink "$HOME/Dotfiles/config/rofi" "$HOME/.config/rofi"
safe-symlink "$HOME/Dotfiles/config/snippet-source" "$HOME/.config/snippet-source"
safe-symlink "$HOME/Dotfiles/config/swaync" "$HOME/.config/swaync"
safe-symlink "$HOME/Dotfiles/config/wofi" "$HOME/.config/wofi"
safe-symlink "$HOME/Dotfiles/config/wlogout" "$HOME/.config/wlogout"

#-- zsh --
safe-symlink "$HOME/Dotfiles/shell/zsh/zsh-theme" "$HOME/.oh-my-zsh/custom/themes/zsh-theme"
safe-symlink "$HOME/Dotfiles/shell/zsh/.zshrc" "$HOME/.zshrc"

#-- scripts --
safe-symlink "$HOME/Dotfiles/scripts/bin" "$HOME/.local/bin"

#-- hypr --
HYPRLAND_CONF_PATH="$HOME/Dotfiles/hosts/$HOSTNAME/hypr/hyprland.conf"
if [ -e "$HYPRLAND_CONF_PATH" ]; then
	mkdir -p "$HOME/.config/hypr"

	safe-symlink "$HOME/Dotfiles/config/hypr/common" "$HOME/.config/hypr/common"
	safe-symlink "$HOME/Dotfiles/config/hypr/hypridle.conf" "$HOME/.config/hypr/hypridle.conf"
	safe-symlink "$HOME/Dotfiles/config/hypr/hyprlock.conf" "$HOME/.config/hypr/hyprlock.conf"
	safe-symlink "$HOME/Dotfiles/config/hypr/hyprpaper.conf" "$HOME/.config/hypr/hyprpaper.conf"
	safe-symlink "$HYPRLAND_CONF_PATH" "$HOME/.config/hypr/hyprland.conf"
fi
