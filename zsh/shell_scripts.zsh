### FUNCTIONS #####

# open github root dir in browser
# https://superuser.com/a/1531797 for shell script
go() {
  git remote -v | head -n 1 | awk -F "@" '{print $2}' | awk -F " " '{print $1}' | sed 's/:/\//g' | sed 's/.git//g' | awk '{print "https://"$0}' | xargs open
}

# pipe tree cmd into less with colors
treel(){ tree -C $1 | less -r; }

# mkdir and cd into it
cdm() { mkdir "$1"; cd "$1"; }

# find file with matching substring
substr_find() {
  find . -name "*$1*" -maxdepth 3 -exec ls -Gdl {} \;
}

# file cmd with colored seperations
# separates filename and information
# TODO could use a program to color filename per type like exa
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

### TODO -- currently includes newline
###### COPY CWD TO PASTEBOARD
# copy-pwd() {
#   pwd | pbcopy
# }
######################  CLEANING #################

### script to autodelete scanned pdfs in downloads (and screenshots)
delete-scans() {

echo "Deleting Adobe Scan PDFs"

let x=0
for f in ~/Downloads/*.pdf; do
  pdfinfo "$f" | grep Adobe\ Scan &> /dev/null && trash "$f" && ((x+=1))
done

echo "Deleted $x item(s)"

unset x

}

## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## 
########## FZF FUNCS ################

# array of bad directorys DONT SEARCH
local EX_DIRS=(".git/" "Music" "release" "target" "python3.11" "node_modules"
      "Photos Library.photoslibrary" "cache" "build" "Application Support"
      "Data" "Packages" ".cargo" ".vscode" "Applications" "Library" "tmp" 
      ".rustup" ".docker")

##### USE FZF TO CD INTO DIR UNDER HOME DIR
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
  if [[ ! -z $selection ]]; then 
    echo $selection
    cd "$selection" 
    echo "---------------------------------------------"
    ls -lG
    echo "---------------------------------------------"
  fi
  vcs_info
  zle reset-prompt
  unset str
  unset selection
  return 0
}

######## USE FZF TO PASTE PATH INTO CLI
fzf-paste-widget() {
  str="find $HOME"
  for ((i=1; i<${#EX_DIRS[@]}+1; i++)); do
    str="$str -not \( -path '"*${EX_DIRS[i]}*"' -prune \) "
  done
  str="$str -not \( -path '/Users/sbarton' \)"
  selection=$(eval "$str" \
    | fzf --height=80% --border=sharp \
      --preview='[[ -d {} ]] && tree -C {} || bat --color=always {}' --preview-window='45%,border-sharp' \
      --prompt='Path > ' \
      --bind='ctrl-o:toggle-preview' \
      --bind='ctrl-a:select-all' \
      --bind='ctrl-x:deselect-all' \
      --pointer='󰜴' --marker='󰄳 ' --multi --color='dark,fg+:red,hl:cyan,hl+:yellow,label:yellow,info:grey' \
      --border-label="Fuzzy Paste Widget"
    )
  [ ! -z $selection ] && LBUFFER="${LBUFFER}'$selection'"
  zle reset-prompt
  unset str
  unset selection
  return 0
}

#### paste from cwd recursive #####
fzf-paste-widget-cwd() {
  str="find ."
  for ((i=1; i<${#EX_DIRS[@]}+1; i++)); do
    str="$str -not \( -path '"*${EX_DIRS[i]}*"' -prune \) "
  done
  str="$str -not \( -path '/Users/sbarton' \)"
  str="$str -not \( -path '.' \)"
  selection=$(eval "$str" \
    | fzf --height=80% --border=sharp \
      --preview='[[ -d {} ]] && tree -C {} || bat --color=always {} ' --preview-window='45%,border-sharp' \
      --prompt='Path > ' \
      --bind='ctrl-o:toggle-preview' \
      --bind='ctrl-a:select-all' \
      --bind='ctrl-x:deselect-all' \
      --pointer='󰜴' --marker='󰄳 ' --multi --color='dark,fg+:red,hl:cyan,hl+:yellow,label:yellow,info:grey' \
      --border-label="Fuzzy Paste Widget CWD"
    )
  [ ! -z $selection ] && LBUFFER="${LBUFFER}'$selection'"
  zle reset-prompt
  unset str
  unset selection
  return 0
}

# CTRL-R - Paste the selected command from history into the command line
fzf-history-widget() {
  local selected num
  setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null
  #selected=( $(fc -rl 1 | awk '{ cmd=$0; sub(/^[ \t]*[0-9]+\**[ \t]+/, "", cmd); if (!seen[cmd]++) print $0 }' |
    # $(fzf --height=80% --border=sharp --scheme=history --bind=ctrl-r:toggle-sort,ctrl-z:ignore --query=${(qqq)LBUFFER} +m)) )
    selected=( $(fc -rl 1 | awk '{ cmd=$0; sub(/^[ \t]*[0-9]+\**[ \t]+/, "", cmd); if (!seen[cmd]++) print $0 }' |
    FZF_DEFAULT_OPTS="--height=80% --border=sharp --scheme=history --bind=ctrl-r:toggle-sort --query=${(qqq)LBUFFER} +m" fzf) )
  local ret=$?
  if [ -n "$selected" ]; then
    num=$selected[1]
    if [ -n "$num" ]; then
      zle vi-fetch-history -n $num
    fi
  fi
  zle reset-prompt
  return $ret
}
