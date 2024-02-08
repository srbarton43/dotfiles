function fzf_cd_cwd_widget
  set -l selection (fd . -u -t d --ignore-file ~/.fdignore \
    | fzf --height=80% --border=sharp \
    --preview='tree -C {}' --preview-window='45%,border-sharp' \
    --prompt='Dirs > ' \
    --bind='ctrl-o:toggle-preview' \
    --bind='ctrl-a:select-all' \
    --bind='ctrl-x:deselect-all' \
    --pointer='󰜴' --marker='󰄳 ' --multi --color='dark,fg+:red,hl:cyan,hl+:yellow,label:yellow,info:grey' \
    --border-label="Fuzzy CD Widget")
  if not test -z $selection
    echo $selection
    cd "$selection" 
    echo "---------------------------------------------"
    ls -lG
    echo "---------------------------------------------"
  end
  commandline -f repaint
  return 0
end
