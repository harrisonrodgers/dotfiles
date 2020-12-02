## Profile
EDITOR='vim'
VISUAL='vim'
PAGER='less'

# Default PS1
PS1='\[\033[01m\]\[\033[01;33m\]\t \u@\h\[\033[00m\]\[\033[01m\]: \[\033[01;32m\]\w\[\033[00m\]\n\[\033[01;33m\]$\[\033[00m\] '

# Enable Colors
eval `dircolors ~/.dircolors`
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Disable XON/XOFF flow control which takes over ctrl+q and ctrl+s (i want normal ctrl+s for forward history search)
stty -ixon

## History
HISTCONTROL=erasedups
HISTSIZE=10000
shopt -s histappend
shopt -s checkwinsize
shopt -s cmdhist
shopt -s globstar
shopt -s checkjobs
