# Oh My Zsh base
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="zsh-theme/$(hostname)"  
plugins=(
  git
  docker             # Docker 使うなら便利
  zsh-autosuggestions
  zsh-syntax-highlighting
  z                   # ディレクトリ移動を賢く
  # さらに必要なら node, kubectl, rust, cargo_plugins など
)

source $ZSH/oh-my-zsh.sh

export VISUAL=$(where nvim)
export EDITOR=$(where nvim)
export SUDO_EDITOR=$(where nvim)
