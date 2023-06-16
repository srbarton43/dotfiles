########## PROMPT ############
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )

show_untracked() { 
  local STATUS=$(git status --porcelain 2> /dev/null | tail --lines=1)
  if [[ -n $STATUS ]]; then
    echo '%F{red}*%f'
  else
    echo ""
  fi
}

is_git() {
  if [[ -n $vcs_info_msg_0_ ]]; then
    branch=$(git symbolic-ref --quiet HEAD 2> /dev/null)
    branch=${branch#refs/heads/}
    echo "%F{green}[$branch]%f"
  else
    echo ""
  fi
}

setopt prompt_subst

PROMPT='$(show_untracked)$(is_git)%F{cyan}[%~% ]%f%B$%b '
RPROMPT="%B%F{red}%? 󰌑%f%b" # exit status to right
