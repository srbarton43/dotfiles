#!/usr/bin/env bash

# Store the STDOUT of fzf in a variable
selection=$(find . -type d -not -path '*/\.git/*' -and -not -path './.git' \
  | fzf --multi --height=80% --border=sharp \
  --preview='tree -C {}' --preview-window='45%,border-sharp' \
  --prompt='Dirs > ' \
  --bind='del:execute(rm -ri {+})' \
  --bind='ctrl-o:toggle-preview' \
  --bind='ctrl-d:change-prompt(Dirs > )' \
  --bind='ctrl-d:+reload(find . -type d -not -path "*/\.git")' \
  --bind='ctrl-d:+change-preview(tree -C {})' \
  --bind='ctrl-d:+refresh-preview' \
  --bind='ctrl-f:change-prompt(Files > )' \
  --bind='ctrl-f:+reload(find . -type f -not -path "*/\.git/*")' \
  --bind='ctrl-f:+change-preview(cat {})' \
  --bind='ctrl-f:+refresh-preview' \
  --bind='ctrl-a:select-all' \
  --bind='ctrl-x:deselect-all' \
  --pointer='󰜴' --marker='󰄳 ' --multi --color='dark,fg+:red,hl:cyan,hl+:yellow,label:yellow,info:grey' \
  --border-label="Fuzzy File Explorer"
)

# Determine what to do depending on the selection
if [[ -d "$selection" ]]; then
  cd "$selection" || exit
elif [[ -n "$selection" ]]; then
  eval "$EDITOR $selection"
else
  echo "Nothing Selected"
fi

