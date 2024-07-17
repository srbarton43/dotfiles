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

  ## keybindings
  bind \ce 'fzf_cd_widget'
  bind \cw 'fzf_cd_cwd_widget'
  bind \cv 'fzf_paste_widget'
  #bind \co 'fzf_paste_cwd_widget'

  ## abbreviations
  abbr -a -- lsa 'ls -A'
  abbr -a -- l 'ls -lh'
  abbr -a -- '-' 'cd -'
  abbr -a -- cl 'clear'
  abbr -a -- '...' 'cd ../../'
  abbr -a -- python python3
  abbr -a -- pip pip3
  abbr -a -- oskim 'open -a Skim'
  abbr -a -- ez 'exec fish'
  abbr -a -- cd 'z'
  abbr -a -- lg 'lazygit'

  # git
  abbr -a -- gg 'git status -s'
  abbr -a -- ggg 'git status'
  abbr -a -- gcm 'git commit -v'
  abbr -a -- ga 'git add'
  abbr -a -- gall 'git add .'
  abbr -a -- gp 'git push'
  abbr -a -- gl 'git log --graph --one-line'
  abbr -a -- cdgr 'cd (git root)' # cd to git root

  ## export variables
  set -xg LSCOLORS 'gxcxcxdxFxaDadabagacad'
  #set -xg LS_COLORS "di=36:ln=32:so=32:pi=33:ex=1;35:bd=30;1;43:cd=30;43:su=30;41:sg=30;46:tw=30;42:ow=30;43" 

  # enable fish completions for nix
  source /nix/var/nix/profiles/default/share/fish/vendor_completions.d/nix.fish
  
  # initialize the prompt
  zoxide init fish | source
  starship init fish | source
end

# opam configuration
# source /Users/sbarton/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
