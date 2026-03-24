# Oh My Zsh base
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="zsh-theme/$(hostname)"  

if [[ "$ZSH_THEME_FLAG" == "subshell" ]]; then
  ZSH_THEME="zsh-theme/subshell"
fi

plugins=(
  git
  docker             # Docker 使うなら便利
  zsh-autosuggestions
  zsh-syntax-highlighting
  z                   # ディレクトリ移動を賢く
  # さらに必要なら node, kubectl, rust, cargo_plugins など
)

source $ZSH/oh-my-zsh.sh

export TERM=xterm-256color
export VISUAL="/usr/local/bin/nvim"
export EDITOR="/usr/local/bin/nvim"
export SUDO_EDITOR="/usr/local/bin/nvim"

if [ -e /home/raia/.nix-profile/etc/profile.d/nix.sh ]; then . /home/raia/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
eval "$(direnv hook zsh)"
