[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'

## Profile
EDITOR='vim'
VISUAL='vim'
PAGER='less'

# Default PS1
PS1='\[\033[01m\]\[\033[01;33m\]\t \u@\h\[\033[00m\]\[\033[01m\]: \[\033[01;32m\]\w\[\033[00m\]\n\[\033[01;33m\]$\[\033[00m\] '

# Enable Colors
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Disable XON/XOFF flow control which takes over ctrl+q and ctrl+s (i want normal ctrl+s for forward history search)
stty -ixon

## History
HISTFILE=~/.zsh_history
HISTSIZE=500000
SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY       # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY     # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY          # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS       # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS   # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS      # Do not display a previously found event.
setopt HIST_IGNORE_SPACE      # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS      # Do not write a duplicate event to the history file.
setopt HIST_VERIFY            # Do not execute immediately upon history expansion.
setopt HIST_BEEP              # Beep when accessing non-existent history.

source ~/.zplug/init.zsh

## Completion
autoload -Uz compinit; compinit
zstyle ':completion:*' menu select                 # autocompletion with an arrow-key driven interface
setopt COMPLETE_ALIASES                            # autocompletion of command line switches for aliases
zstyle ':completion::complete:*' gain-privileges 1 # autocompletion of privileged environments in privileged commands
zplug "zsh-users/zsh-history-substring-search", defer:3

## Prompt
export STARSHIP_CONFIG=~/.config/starship/starship.toml
eval "$(starship init zsh)"

## Dircolors
DIRCOLORS_SOLARIZED_ZSH_THEME="256dark"
zplug "pinelibg/dircolors-solarized-zsh"

## Syntax
zplug "zlsun/solarized-man", from:github, use:"solarized-man.plugin.zsh"
zplug "zsh-users/zsh-syntax-highlighting", defer:2

## Keys
bindkey -v
# Ensure delete key works as expected
bindkey "\e[3~" delete-char
# Ensure backspace works in Vi mode
bindkey -v '^?' backward-delete-char
# Retain CTRL+R and CTRL+S in Vi mode
bindkey -v "^R" history-incremental-search-backward
bindkey -v "^S" history-incremental-search-forward

## Zplug
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
if ! zplug check; then
    zplug install
    zplug load --verbose
fi
zplug load
