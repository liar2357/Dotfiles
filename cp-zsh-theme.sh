#!/usr/bin/env bash

source $HOME/Dotfiles/scripts/lib/safe-symlink.sh
HOSTNAME=$(hostname)

#-- zsh --
safe-symlink "$HOME/Dotfiles/shell/zsh/self.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/self.zsh-theme"
