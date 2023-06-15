local api = vim.api
local keymap = vim.keymap
local dashboard = require("dashboard")

local conf = {}
conf.header = {
  "                                                       ",
  "                                                       ",
  "                                                       ",
  " ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
  " ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
  " ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
  " ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
  " ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
  " ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
  "                                                       ",
  "                                                       ",
  "                                                       ",
  "                                                       ",
}

conf.center = {
  {
    icon = "󰈞  ",
    desc = "Find  File                              ",
    action = ":lua require('telescope.builtin').find_files{}",
    key = "<Leader>ff",
  },
  {
    icon = "  ",
    desc = "Recently opened files                   ",
    action = ":lua require('telescope.builtin').oldfiles{}",
    key = "<Leader>fr",
  },
  {
    icon = "󱆃  ",
    desc = "Project grep                            ",
    action = ":lua require('telescope.builtin').live_grep{}",
    key = "<Leader>fg",
  },
  {
    icon = "  ",
    desc = "Open Nvim config                        ",
    action = "tabnew $MYVIMRC | tcd %:p:h",
    key = "<Leader>ev",
  },
  {
    icon = "  ",
    desc = "New file                                ",
    action = "enew",
    key = "e",
  },
  {
    icon = "󰩈  ",
    desc = "Quit Nvim                               ",
    -- desc = "Quit Nvim                               ",
    action = "qa",
    key = "q",
  },
}

dashboard.setup({
  theme = 'doom',
  shortcut_type = 'number',
  config = conf
})

api.nvim_create_autocmd("FileType", {
  pattern = "dashboard",
  group = api.nvim_create_augroup("dashboard_enter", { clear = true }),
  callback = function ()
    keymap.set("n", "q", ":qa<CR>", { buffer = true, silent = true })
    keymap.set("n", "e", ":enew<CR>", { buffer = true, silent = true })
  end
})
