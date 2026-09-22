#!/usr/bin/env bash

source $HOME/Dotfiles/scripts/lib/safe-symlink.sh
HOSTNAME=$(hostname)

#-- .config --
safe-symlink "$HOME/Dotfiles/config/fastfetch" "$HOME/.config/fastfetch"
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
safe-symlink "$HOME/Dotfiles/config/hypr" "$HOME/.config/hypr"

safe-symlink "$HOME/Dotfiles/config/md2pdf" "$HOME/.config/md2pdf"
safe-symlink "$HOME/Dotfiles/share/typst" "$HOME/.local/share/typst"

safe-symlink "$HOME/Dotfiles/config/emu-board" "$HOME/.config/emu-board"

#-- zsh --
safe-symlink "$HOME/Dotfiles/shell/zsh/self.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/self.zsh-theme"
safe-symlink "$HOME/Dotfiles/shell/zsh/.zshrc" "$HOME/.zshrc"

#--- tmux ---
safe-symlink "$HOME/Dotfiles/tmux/tmux/.tmux.conf" "$HOME/.tmux.conf"

#-- scripts --
safe-symlink "$HOME/Dotfiles/scripts/bin" "$HOME/.local/bin"

