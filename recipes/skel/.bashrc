# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
PATH="$HOME/.local/bin:$HOME/bin:$PATH"
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

#youtube-dl
alias yt="youtube-dl -if webm+bestaudio"
#youtube-dl playlist
alias ytp="youtube-dl -Atif webm+bestaudio"
#youtube-dl music only
alias ytm="youtube-dl -if bestaudio"

# dnf update
alias da="sudo dnf update"
# dnf install
alias di="sudo dnf install"
# dnf remove
alias dr="sudo dnf remove"
# dnf info
alias dif="sudo dnf info"
# dnf autoremove
alias dx="sudo dnf autoremove"
# dnf search
alias ds="sudo dnf search"
