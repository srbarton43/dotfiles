########## PROMPT ############
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
zstyle ':vcs_info:git:*' formats '%b'

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
    echo "%F{green}[${vcs_info_msg_0_}]%f"
  else
    echo ""
  fi
}

setopt prompt_subst

PROMPT='$(show_untracked)$(is_git)%F{cyan}[%~% ]%f%B$%b '
RPROMPT="%B%F{red}%? 󰌑%f%b" # exit status to right
