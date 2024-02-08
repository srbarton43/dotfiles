-- define common options
local opts = {
  noremap = true,   -- non-recursive
  silent = true,    -- do not show message
}

-----------------
-- Normal mode --
-----------------

-- Resize with arrows
-- delta: 2 lines
-- these don't work on macos?
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-- search always in middle of screen
vim.keymap.set('n', 'n', 'nzz', opts);
vim.keymap.set('n', 'N', 'Nzz', opts);

-- save file with C-s
vim.keymap.set('n', '<C-s>', ':w<CR>', opts)

-----------------
-- Visual mode --
-----------------

-- Hint: start visual mode with the same area as the previous area and the same mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-----------------
-- Insert Mode --
-----------------

-- move cursor one char right in insert mode
vim.keymap.set('i', '<C-e>', '<Right>', opts)

-- save in insert mode with C-s
vim.keymap.set('i', '<C-s>', '<C-o>:w<CR>', opts)

-- open pdf viewer in insert mode 
--vim.keymap.set('i', '<C-v', '<C-o>:VimtexView', opts)
