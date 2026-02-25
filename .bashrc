## general bash configuration
##
ulimit -n 12288
ulimit -c unlimited

# Enable incremental search in history
#bind '"\C-r": "\C-r\C-p"'

# Don't save duplicates, or lines that begin with a space
export HISTCONTROL=ignoreboth

# Append history rather than overwriting it when the shell exits
shopt -s histappend

# Set a large history size
export HISTSIZE=10000
export HISTFILESIZE=20000

# Make Bash tab-completion case-insensitive
bind "set completion-ignore-case on"
##

## ENV VARS
##
eval "$(/opt/homebrew/bin/brew shellenv)"
export HDF5_DIR="$(brew --prefix hdf5)"
export PYENV_ROOT="$HOME/.pyenv"
export DYLD_LIBRARY_PATH=/opt/homebrew/lib:$DYLD_LIBRARY_PATH
export PATH="$PYENV_ROOT/bin:$PYENV_ROOT/shims:$PATH"
export PATH=$PATH:`xcode-select -p`/usr/local/bin

export LDFLAGS="-L/usr/local/lib -L$(brew --prefix)/lib"
export CPPFLAGS="-I/usr/local/include -I$(brew --prefix)/include"
export CMAKE_PREFIX_PATH=$(brew --prefix)
export DYLD_FALLBACK_LIBRARY_PATH="$(brew --prefix)/lib:/usr/local/lib"

export LSCOLORS='gxcxcxdxFxaDadabagacad'
##

## Aliai
##
alias l='ls -lh'
alias ls='ls -G'
alias ll='ls -alh'
alias la='ls -a'
alias lsa='ls -A'

alias cd='z'
alias '..'='cd ..'
alias '...'='cd ../../'
#alias '-'='cd -'

alias less='less -S'
alias tree='tree -C'

# git
alias gg='git status -s'
alias ggg='git status'
alias gcm='git commit -v'
alias ga='git add'
alias gall='git add .'
alias gp='git push'
alias gl='git log --graph --one-line'
alias cdgr='cd $(git rev-parse --show-toplevel)' # cd to git root
##

## Simple Functions
##
function cdm() {
  mkdir -p $1 && cd $1
}
##

## Shell setup stuff
##
eval "$(starship init bash)"
eval "$(zoxide init bash)"
##
