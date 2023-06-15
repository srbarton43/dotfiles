-- keybinds
-- define common options
local opts = {
    noremap = true,      -- non-recursive
    silent = true,       -- do not show message
}

-----------------
-- Normal mode --
-----------------

vim.keymap.set('n', '<leader>ff', ':lua require("telescope.builtin").find_files{}<CR>', opts)
vim.keymap.set('n', '<leader>fr', ':lua require("telescope.builtin").oldfiles{}<CR>', opts)
vim.keymap.set('n', '<leader>fg', ':lua require("telescope.builtin").live_grep{}<CR>', opts)
