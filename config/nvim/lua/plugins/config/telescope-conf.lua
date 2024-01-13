require('telescope').setup {
  file_ignore_patterns = { ".git/.*", },
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
    find_files = {
      file_ignore_patterns = { ".git/.*", ".*.pdf", ".*.png", ".*.PNG", ".*.jpeg", ".*.xlsx", },
      hidden = true,
      theme = "dropdown",
      previewer = false,
    },
    oldfiles = {
      file_ignore_patterns = { ".git/.*", },
      theme = "dropdown",
      previewer = false,
    },
    live_grep = {
      file_ignore_patterns = { ".git/.*", ".*.pdf", ".*.png", ".*.PNG", ".*.jpeg", ".*.xlsx", },
      theme = "dropdown",
    }
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
    fzf = {
      fuzzy = true,                   -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,    -- override the file sorter
      case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    }
  }
}
require('telescope').load_extension('fzf') -- keybinds

-- define common options
local opts = {
  noremap = true, -- non-recursive
  silent = true,  -- do not show message
}

-----------------
-- Normal mode --
-----------------

vim.keymap.set('n', '<leader>ff', ':lua require("telescope.builtin").find_files{}<CR>', opts)
vim.keymap.set('n', '<leader>fr', ':lua require("telescope.builtin").oldfiles{}<CR>', opts)
vim.keymap.set('n', '<leader>fg', ':lua require("telescope.builtin").live_grep{}<CR>', opts)
vim.keymap.set('n', '<leader>fb', ':lua require("telescope.builtin").buffers{}<CR>', opts)
