--[[
-- this file contains nvim autocommands
--]]

-- turn off completions inside markdown files
-- https://github.com/NvChad/NvChad/discussions/2397
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { '*.md' },
  callback = function()
    require('cmp').setup.buffer { enabled = false }
  end
})
