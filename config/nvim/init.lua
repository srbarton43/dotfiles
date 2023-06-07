require("options")
require("plugins")
require("keymaps")

local path = string.format("%s/core/%s", vim.fn.stdpath("config"), "plugins.vim")
local source_cmd = "source " .. path
vim.cmd(source_cmd)
