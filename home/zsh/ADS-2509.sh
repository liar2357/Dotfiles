# Oh My Zsh base
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="self"  # / 好みに応じて “robbyrussell” など
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
