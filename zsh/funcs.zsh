### FUNCTIONS #####

# pipe tree cmd into less with colors
treel(){ tree -C $1 | less -r; }

# mkdir and cd into it
cdm() { mkdir "$1"; cd "$1"; }

# find file with matching substring
substr_find() {
  find . -name "*$1*" -maxdepth 3 -exec ls -Gdl {} \;
}

# file cmd with colored seperations
color_file() {
  file "$1" | sed -e 's/^/'"$(printf '\033[0;34m')"'/' -e 's/:/&'"$(printf '\033[0m')"'/'
}

## tmux aliases
killw() {
  if [[ "$TERM_PROGRAM" = tmux ]]; then
    tmux killw
  else
    echo "not in tmux session"
  fi
}

killp() {
  if [[ "$TERM_PROGRAM" = tmux ]]; then
    tmux killp
  else
    echo "not in tmux session"
  fi
}

# array of bad directorys DONT SEARCH
local EX_DIRS=(".git" "Music" "release" "target" "python3.11" "node_modules"
      "Photos Library.photoslibrary" "cache" "build" "Application Support"
      "Data" "Packages" ".cargo" ".vscode" "Applications" "Library" "tmp" 
      ".rustup" ".docker")

fzf-cd-widget() {
  #construct 'find' flags string
  local str="find ~ -type d"
  for ((i=1; i<${#EX_DIRS[@]}+1; i++)); do
    str="$str -not \( -path '"*${EX_DIRS[i]}*"' -prune \) "
  done
  str="$str -not \( -path '/Users/sbarton' \)"
  selection=$(eval "$str" \
      | fzf --height=80% --border=sharp \
      --preview='tree -C {}' --preview-window='45%,border-sharp' \
      --prompt='Dirs > ' \
      --bind='ctrl-o:toggle-preview' \
      --bind='ctrl-a:select-all' \
      --bind='ctrl-x:deselect-all' \
      --pointer='󰜴' --marker='󰄳 ' --multi --color='dark,fg+:red,hl:cyan,hl+:yellow,label:yellow,info:grey' \
      --border-label="Fuzzy CD Widget"
    )
  echo $selection
  [[ ! -z $selection ]] && cd "$selection" && ls -G
  zle reset-prompt
  unset str
  unset selection
  return 0
}

fzf-paste-widget() {
  str="find $HOME"
  for ((i=1; i<${#EX_DIRS[@]}+1; i++)); do
    str="$str -not \( -path '"*${EX_DIRS[i]}*"' -prune \) "
  done
  str="$str -not \( -path '/Users/sbarton' \)"
  selection=$(eval "$str" \
    | fzf --height=80% --border=sharp \
      --preview='tree -C {}' --preview-window='45%,border-sharp' \
      --prompt='Path > ' \
      --bind='ctrl-o:toggle-preview' \
      --bind='ctrl-a:select-all' \
      --bind='ctrl-x:deselect-all' \
      --pointer='󰜴' --marker='󰄳 ' --multi --color='dark,fg+:red,hl:cyan,hl+:yellow,label:yellow,info:grey' \
      --border-label="Fuzzy Paste Widget"
    )
  LBUFFER="${LBUFFER}\"$selection\""
  zle reset-prompt
  unset str
  unset selection
  return 0
}
