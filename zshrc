export LSCOLORS=gxcxcxdxFxaDadabagacad
LS_COLORS="di=36:ln=32:so=32:pi=33:ex=1;35:bd=30;1;43:cd=30;43:su=30;41:sg=30;46:tw=30;42:ow=30;43" 

#### Autocomplete Case-insensitive #####
autoload -Uz compinit && compinit
setopt MENU_COMPLETE        # Automatically highlight first element of completion menu
setopt AUTO_LIST            # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD     # Complete from both ends of a word.

# Define completers
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$~/.zsh/.zcompcache"
zstyle ':completion:*' menu select

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Only display some tags for the command cd
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories

# Required for completion to be in good groups (named after the tags)
zstyle ':completion:*' group-name ''

zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands

# See ZSHCOMPWID "completion matching control"
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

zstyle ':completion:*' keep-prefix true

zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'


########## PROMPT ############
PROMPT='%F{cyan}[%~% ]%f%B$%b '

##### CMD History   #####
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "$key[Up]" up-line-or-beginning-search # Up
bindkey "$key[Down]" down-line-or-beginning-search # Down


########## Aliases #############
alias ls="ls -G"
alias ll="ls -alh"
alias l="ls -lh"
alias py="python3"
alias pip="pip3"
alias cdp="cd .."
alias gittree="tree -a --gitignore -I .git"
# pipe tree cmd into less with colors
treeless(){ tree -C $1 | less -r; }
# mkdir and cd into it
cdm() { mkdir "$1"; cd "$1"; }

###### GIT Aliases ############
alias gg="git status"
alias gcm="git commit -v"
alias ga="git add"
alias gap="git add -p"
alias gall="git add ."
alias gl="git log --graph --one-line"
alias gd="git diff"
alias gp="git push"

######### PATH ##############
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
export PATH="/Users/sbarton/Library/Python/3.11/bin:$PATH"
export PATH="/opt/homebrew/opt/binutils/bin:$PATH"
export PATH=$PATH:'/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home/bin'
export PATH=/Library/Frameworks/Python.framework/Versions/Current/bin:/opt/homebrew/bin:$PATH

######### Other #############
export EDITOR="nvim"
