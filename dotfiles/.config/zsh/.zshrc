# https://github.com/unixorn/awesome-zsh-plugins

source ~/.config/zsh/zplug/init.zsh

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

# Muscle Memory
alias vim="nvim"
alias ls="exa --git --binary"
alias cat="bat"

## Completion
autoload -Uz compinit; compinit
#zstyle ':completion:*' menu select                 # autocompletion with an arrow-key driven interface
setopt COMPLETE_ALIASES                            # autocompletion of command line switches for aliases
zstyle ':completion::complete:*' gain-privileges 1 # autocompletion of privileged environments in privileged commands
zplug "zsh-users/zsh-history-substring-search", defer:3
zplug "Aloxaf/fzf-tab", from:github, use:"fzf-tab.plugin.zsh"

## Prompt
export STARSHIP_CONFIG=~/.config/starship/starship.toml
eval "$(starship init zsh)"

## Dircolors
DIRCOLORS_SOLARIZED_ZSH_THEME="256dark"
zplug "pinelibg/dircolors-solarized-zsh"

## Syntax
zplug "zlsun/solarized-man", from:github, use:"solarized-man.plugin.zsh"
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# Python Development
alias ,bs_full="conda install jedi mypy pylama pylint flake8 flake8-comprehensions flake8-mutable flake8-bugbear flake8-builtins pydocstyle black isort -y ; and pip --no-cache-dir install flake8-mock flake8-pytest"
alias ,bs="conda install pylama pylint flake8-builtins pydocstyle -y ; and pip --no-cache-dir install flake8-mock flake8-pytest"

# Conda activate
alias ca="if ! test -f tasks.py ; then echo 'Not a supported repo, no tasks.py found.' && return 1 ; fi ; conda deactivate && basename=`basename $PWD` && conda activate /media/storage/envs/$basename"

# Conda recreate
alias cr="if ! test -f tasks.py ; then echo 'Not a supported repo, no tasks.py found.' && return 1 ; fi ; conda deactivate && basename=`basename $PWD` && rm -rf /media/storage/envs/$basename && conda create -p /media/storage/envs/$basename python=3.6.8 invoke --yes --quiet && conda activate /media/storage/envs/$basename && inv bootstrap develop hooks"

# Less colors (for man)
#set -xU LESS_TERMCAP_md `printf "\e[01;31m"`
#set -xU LESS_TERMCAP_me `printf "\e[0m"`
#set -xU LESS_TERMCAP_se `printf "\e[0m"`
#set -xU LESS_TERMCAP_so `printf "\e[01;43;97m"`
#set -xU LESS_TERMCAP_ue `printf "\e[0m"`
#set -xU LESS_TERMCAP_us `printf "\e[01;32m"`

# Man colors
MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Less colors (source code highlighting, warning it may be slow so use `less -L` to disable)
LESSOPEN="| bat --color=always %s"
LESS='-R --mouse --wheel-lines=5 --quit-if-one-screen'

# FZF
source ~/.config/zsh/fzf/completion.zsh
source ~/.config/zsh/fzf/key-bindings.zsh
zstyle ":completion:*:git-checkout:*" sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':fzf-tab:*' default-color $'\033[92m'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
FZF_DEFAULT_COMMAND="rg --files --hidden"
FZF_DEFAULT_OPTS="
  --no-height
  --no-reverse
  --color=bg+:#eee8d5,bg:#fdf6e3,spinner:#2aa198,hl:#268bd2
  --color=fg:#657b83,header:#268bd2,info:#859900,pointer:#2aa198
  --color=marker:#2aa198,fg+:#cb4b16,prompt:#859900,hl+:#268bd2
"
ZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
#FZF_CTRL_T_OPTS='
#--preview \'switch (file --mime {}) 
#  case "*inode/directory*"
#    tree -C {}
#  case "*binary*"
#    file {} 
#  case "*"
#    bat {} --color=always --style="numbers,changes"
#  end\'
#'

# Disable XON/XOFF flow control which takes over ctrl+q and ctrl+s (i want normal ctrl+s for forward history search)
#stty -ixon

## Keys (VI Mode)
#bindkey -v
# Ensure delete key works as expected
#bindkey "\e[3~" delete-char
# Ensure backspace works in Vi mode
#bindkey -v '^?' backward-delete-char
# Retain CTRL+R and CTRL+S in Vi mode
#bindkey -v "^R" history-incremental-search-backward
#bindkey -v "^S" history-incremental-search-forward

## Zplug
#zplug 'zplug/zplug', hook-build:'zplug --self-manage'
if ! zplug check; then
    zplug install
fi
zplug load
