vim.cmd([[
  set termguicolors
  colorscheme monokai
  autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
  if argc() != 0
    autocmd VimEnter * e
  endif

]])

-- Custom mapping <leader> (see `:h mapleader` for more info)
vim.g.mapleader = ','

require("options")
require("plugins")
require("keymaps")

local path = string.format("%s/core/%s", vim.fn.stdpath("config"), "plugins.vim")
local source_cmd = "source " .. path
vim.cmd(source_cmd)
