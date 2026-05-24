echo "luanch zsh"

if [[ -z "$ZSH_FIRST_SHELL" ]]; then
	export ZSH_FIRST_SHELL=1
	export ZSH_SUBSHELL_LEVEL=0
else
	export ZSH_SUBSHELL_LEVEL=$((ZSH_SUBSHELL_LEVEL + 1))
fi

# Oh My Zsh base
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="self-termux"  

plugins=(
  git
  docker             # Docker 使うなら便利
  zsh-autosuggestions
  zsh-syntax-highlighting
  z                   # ディレクトリ移動を賢く
  # さらに必要なら node, kubectl, rust, cargo_plugins など
)
source $ZSH/oh-my-zsh.sh

alias pd='proot-distro'
alias bl='~/scripts/proot-boot.sh'

# Termux のシェル起動時に一度だけメニューを出す
if [ -z "$PROOT_BOOT_DONE" ]; then
  export PROOT_BOOT_DONE=1
  echo "Termux booted"
  # ここでブートメニューを呼ぶ
  $HOME/scripts/proot-boot.sh
fi

