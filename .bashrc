#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='eza -lao --no-user --icons=always --group-directories-first'
alias grep='grep --color=auto'
PS1="\[\033[38;2;166;227;161m\]\u\[\033[0m\]@\
\[\033[38;2;137;180;250m\]\h\[\033[0m\]:\
\[\033[38;2;249;226;175m\]\w\[\033[0m\] \
\[\033[38;2;245;194;231m\]\$(git branch 2>/dev/null | grep '^\*' | colrm 1 2 | sed 's/^/ (/' | sed 's/\$/)/')\
\[\033[0m\]\[\033[38;2;205;214;244m\]\$ \[\033[0m\]"


fastfetch
. "$HOME/.cargo/env"
alias config='/usr/bin/git --git-dir=/home/ash/.cfg/ --work-tree /home/ash'
