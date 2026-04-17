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
alias onlyoffice='GDK_BACKEND=x11 onlyoffice-desktopeditors'
alias lg='lazygit'
alias vivaldi='flatpak run com.vivaldi.Vivaldi'
alias discord='flatpak run com.discordapp.Discord'
alias wssh='waypipe ssh -Y'
alias nd='nix develop -c $SHELL'
alias nfu='nix flake update'
alias tl='tmux ls'
alias tr='tmux source-file ~/.tmux.conf'
alias db='distrobox'
alias db-e='distrobox enter'
alias db-l='distrobox list'

ta() {
	if tmux has-session -t "$1" 2>/dev/null; then
		tmux attach -t "$1"
	else
		tmux new -s "$1"
	fi
}

tm() {
	if [ -z "$TMUX" ]; then
		tmux attach || tmux new
	else
		echo "tmux is already running"
	fi
}

function touch-p() {
	mkdir -p $(dirname "$1") && touch "$1"
}

vclip() {
	ffmpeg -ss "$1" -to "$2" -i "$3" -c copy "cut_$3"
}
