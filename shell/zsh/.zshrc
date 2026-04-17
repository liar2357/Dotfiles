export COLORTERM=truecolor

HOSTNAME=$(hostname)

if [[ -n $CONTAINER_ID ]]; then
	source ~/Dotfiles/hosts/distrobox/zsh/zshrc.sh
else
	source ~/Dotfiles/hosts/$HOSTNAME/zsh/zshrc.sh
fi

# ------------------------------------------------
# エイリアス (必要に応じて追加)

source $HOME/Dotfiles/shell/COMMON/alias-and-function.sh

# ------------------------------------------------
# 履歴 (history) 設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS

# ------------------------------------------------
# 補完設定 (もし追加するなら)
autoload -Uz compinit
compinit

# ------------------------------------------------
# プロンプトやショートカットなど (必要に応じて)
# 例: ディレクトリ名だけで cd
setopt AUTO_CD
# コマンド間違い軽減 (必要なら)  
setopt CORRECT

# ------------------------------------------------



# ------------------------------------------------
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export PATH="$PATH:/usr/lib/rustup/bin"
export PATH="$HOME/.cargo/bin:/home/raia/.local/bin:$PATH"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

