filetype plugin indent on
syntax enable
let g:vimtex_compiler_latexrun_engines = {'_': 'lualatex'}
let g:vimtex_compiler_latexmk_engines = {'_': '-lualatex'}
let g:vimtex_compiler_latexmk = {
            \ 'options' : [
                \   '-shell-escape',
                \   '-verbose',
                \   '-file-line-error',
                \   '-synctex=1',
                \   '-interaction=nonstopmode',
                \ ],
                \}
let g:vimtex_syntax_packages = {'minted': {'load': 2}}
function! s:TexFocusVim() abort
  " Replace `TERMINAL` with the name of your terminal application
  " Example: execute "!open -a iTerm"  
  " Example: execute "!open -a Alacritty"
  silent execute "!open -a iTerm"
  redraw!
endfunction

augroup vimtex_event_focus
  au!
  au User VimtexEventViewReverse call s:TexFocusVim()
augroup END

