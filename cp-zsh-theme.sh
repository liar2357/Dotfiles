#!/usr/bin/env bash

source $HOME/Dotfiles/scripts/lib/safe-symlink.sh
HOSTNAME=$(hostname)

#-- zsh --
safe-symlink "$HOME/Dotfiles/shell/zsh/zsh-theme" "$HOME/.oh-my-zsh/custom/themes/zsh-theme"
