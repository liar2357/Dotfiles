echo "luanch zsh"
# Oh My Zsh base
export ZSH="$HOME/.oh-my-zsh"

if (( ZSH_SUBSHELL_LEVEL > 0 )); then
  ZSH_THEME="zsh-theme/subshell"
else
  ZSH_THEME="zsh-theme/$(hostname)"  
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

export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export LC_CTYPE=ja_JP.UTF-8
