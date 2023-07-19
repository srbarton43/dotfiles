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

# find . -type d -not -path '*/\.git/*' -and -not -path './.git' -and -not -path '*Music*' -and -not -path '*packer*' -and -not -path '*release*' -and -not -path '*target*' -and -not -path '*python3.11*' -and -not -path '*node_modules*' -and -not -path '*Photos Library.photoslibrary*' -and -not -path '*cache*' -and -not -path '*build*' -and -not -path '*Application Support*' -and -not -path '*Data*' -and -not -path "*Packages*" -and -not -path '*.cargo/*' -and -not -path '*.vscode/*' -and -not -path '*Applications*' -and -not -path '*Library*' -and -not -path '*tmp*'\
  
# find . -type d \( -name \.git -o -name Music -o -name packer -o -name release -o -name target -o -name python3.11 -o -name node_modules -o -name "Photos Library.photoslibrary" -o -name cache -o -name "Application Support" -o -name Data -o -name Packages -o -name '.cargo' -o -name '.vscode' -o -name Applications -o -name Library -o -name tmp \) -prune -print

fzf-cd-widget() {
  selection=$(find . -type d -not \( -path '*.git*' -prune \) -not \( -path '*Music*' -prune \) -not \( -path '*packer*' -prune \) -not \( -path '*release*' -prune \) -not \( -path '*target*' -prune \) -not \( -path '*python3.11*' -prune \) -not \( -path '*node_modules*' -prune \) -not \( -path '*Photos Library.photoslibrary*' -prune \) -not \( -path '*cache*' -prune \) -not \( -path '*build*' -prune \) -not \( -path '*Application Support*' -prune \) -not \( -path '*Data*' -prune \) -not \( -path '*Packages*' -prune \) -not \( -path '*.cargo*' -prune \) -not \( -path '*.vscode*' -prune \) -not \( -path '*Applications*' -prune \) -not \( -path '*Library*' -prune \) -not \( -path '*tmp*' -prune \) -not \( -path '.' \) \
      | fzf --multi --height=80% --border=sharp \
      --preview='tree -C {}' --preview-window='45%,border-sharp' \
      --prompt='Dirs > ' \
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
    cd "$selection"
  zle reset-prompt
  return 0
}
