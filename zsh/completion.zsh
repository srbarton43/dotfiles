#### Autocomplete Case-insensitive #####
fpath+=/Users/sbarton/.zsh/completion/
zmodload -i zsh/complist
autoload -Uz compinit && compinit -i
unsetopt MENU_COMPLETE        # Don't automatically highlight first element of completion menu
setopt AUTO_MENU            # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD     # Complete from both ends of a word.
setopt ALWAYS_TO_END

# Define completers
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$~/.zsh/.zcompcache"
zstyle ':completion:*' single-ignored complete
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|=*' 'l:|=* r:|=*'
# tab select highlighting gray with white text 48;5;bg-256;42;5;fg-256
# https://chrisyeh96.github.io/2020/03/28/terminal-colors.html
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} "ma=48;5;235;38;5;255"
zstyle ':completion:' special-dirs true
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes
# kill colors
zstyle ':completion:*:*:kill:*processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
# Required for completion to be in good groups (named after the tags)
zstyle ':completion:*' group-name ''
zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

##### CMD History #####
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# go to pathname w/o 'cd'
setopt autocd 
