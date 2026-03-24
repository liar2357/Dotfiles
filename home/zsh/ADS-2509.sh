if [[ -z "$ZSH_FIRST_SHELL" ]]; then
	export ZSH_FIRST_SHELL=1
	export ZSH_SUBSHELL_LEVEL=0
else
	export ZSH_SUBSHELL_LEVEL=$((ZSH_SUBSHELL_LEVEL + 1))
fi

# Oh My Zsh base
export ZSH="$HOME/.oh-my-zsh"

if ((ZSH_SUBSHELL_LEVEL > 0)); then
	ZSH_THEME="zsh-theme/subshell"
else
	ZSH_THEME="zsh-theme/$(hostname)"
fi

plugins=(
	git
	docker # Docker 使うなら便利
	zsh-autosuggestions
	zsh-syntax-highlighting
	z # ディレクトリ移動を賢く
	# さらに必要なら node, kubectl, rust, cargo_plugins など
)

source $ZSH/oh-my-zsh.sh

export TERM=xterm-256color
export VISUAL="/usr/local/bin/nvim"
export EDITOR="/usr/local/bin/nvim"
export SUDO_EDITOR="/usr/local/bin/nvim"

if [ -e /home/raia/.nix-profile/etc/profile.d/nix.sh ]; then . /home/raia/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
eval "$(direnv hook zsh)"
