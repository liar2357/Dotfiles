export COLORTERM=truecolor

# ------------------------------------------------
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

# ------------------------------------------------
# エイリアス (必要に応じて追加)
alias ls='ls -lAh'
alias lsr='ls -lAhR'
alias gs='git status'
alias gc='git commit'
alias gp='git push'
alias ..='cd ..'
alias ...='cd ../..'
alias hisg='history | grep'
alias his='history'
alias nvr='NVIM_APPNAME=nvim nvim'
alias nvl='NVIM_APPNAME=nvim-lite nvim'
alias packet='flatpak run io.github.nozwock.Packet'
alias chteame='./.config/hypr/scripts/chteame.sh'

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
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
export PATH="$PATH:/usr/lib/rustup/bin"
export PATH="$HOME/.cargo/bin:$PATH"
