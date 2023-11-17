local options = {
  termguicolors = true,
  conceallevel = 0,                        -- so that `` is visible in markdown files
  fileencoding = "utf-8",                  -- the encoding written to a file
  hlsearch = true,                         -- highlight all matches on previous search pattern
  ignorecase = true,                       -- ignore case in search patterns
  mouse = "a",                             -- allow the mouse to be used in neovim
  smartcase = true,                        -- smart case
  smartindent = true,                      -- make indenting smarter again
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  expandtab = true,                        -- convert tabs to spaces
  shiftwidth = 2,                          -- the number of spaces inserted for each indentation
  tabstop = 2,                             -- insert 2 spaces for a tab
  number = true,                           -- set numbered lines
  relativenumber = false,                  -- set relative numbered lines
  showmode = false,                        -- don't show '--insert' at bottom
  showcmd = true,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd("syntax on")

-- INDENT -- (see also vimtex.lua)
vim.g['tex_flavor'] = 'latex'
vim.g['tex_indent_items'] = 0              -- turn off enumerate indent
vim.g['tex_indent_brace'] = 0              -- turn off brace indent
-- vim.g['tex_indent_and'] = 0             -- whether to align with &
-- vim.g['latex_indent_enabled'] = 0
-- vim.g['vimtex_indent_enabled'] = 0
-- vim.g['did_indent'] = 1

-- autocmds
local api = vim.api

-- go to last loc in a file
api.nvim_create_autocmd(
    "BufReadPost",
    { command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]] }
  )

-- for better escape
vim.g['better_escape_shortcut'] = {'jk', 'kj', 'JK', 'KJ'}
vim.opt.runtimepath:remove("/usr/share/vim/vimfiles")  -- separate vim plugins from neovim in case vim still in use
vim.o.signcolumn = "yes"
vim.g.mapleader = ','


-- luasnip selection mode
require("luasnip").config.set_config({ -- Setting LuaSnip config
  -- Use <Tab> (or some other key if you prefer) to trigger visual selection
  store_selection_keys = "<Tab>",
})
