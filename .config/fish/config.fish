if status is-interactive
  # Emulates vim's cursor shape behavior
  # Set the normal and visual mode cursors to a block
  set fish_cursor_default block
  # Set the insert mode cursor to a line
  set fish_cursor_insert line
  # Set the replace mode cursors to an underscore
  set fish_cursor_replace_one underscore
  set fish_cursor_replace underscore
  # Set the external cursor to a line. The external cursor appears when a command is started.
  # The cursor shape takes the value of fish_cursor_default when fish_cursor_external is not specified.
  set fish_cursor_external line
  # The following variable can be used to configure cursor shape in
  # visual mode, but due to fish_cursor_default, is redundant here
  set fish_cursor_visual block

  # keybindings
  bind \ce 'fzf_cd_widget'
  bind \cp 'fzf_paste_widget'
  bind \co 'fzf_paste_cwd_widget'

  # abbreviations

  # git
  abbr -a -- gg 'git status'
  abbr -a -- gcm 'git commit -v'
  abbr -a -- gall 'git add .'
  
  # initialize the prompt
  starship init fish | source
end
