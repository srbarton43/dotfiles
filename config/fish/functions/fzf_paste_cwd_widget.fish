function fzf_paste_cwd_widget
  set -l selection (fd -u --ignore-file ~/.fdignore \
  | fzf --height=80% --border=sharp \
    --preview='tree -C {}' --preview-window='45%,border-sharp' \
    --prompt='Dirs > ' \
    --bind='ctrl-o:toggle-preview' \
    --bind='ctrl-a:select-all' \
    --bind='ctrl-x:deselect-all' \
    --pointer='󰜴' --marker='󰄳 ' --multi --color='dark,fg+:red,hl:cyan,hl+:yellow,label:yellow,info:grey' \
    --border-label="Fuzzy Paste Widget CWD")
  commandline -t -r \"$selection\"
  commandline -f repaint
  return 0
end
