return {
  "tanvirtin/monokai.nvim", -- monokai themes
  priority = 1000,
  config = function()
    local monokai = require('monokai')
    local palette = monokai.classic
    local nvim_set_hl = vim.api.nvim_set_hl
    monokai.setup({
      palette = {
        base2 = '#121212', -- make bg darker
        green = '#86fa04', -- i like this green better
      },
      custom_hlgroups = {
        GitSignsAdd = {
          fg = '#86fa04',   -- green
        },
        GitSignsDelete = {
          fg = palette.pink,
        },
        DiagnosticError = {
          fg = "Red",
        },
        DiagnosticWarn = {
          fg = "Orange",
        },
        DiagnosticInfo = {
          fg = "LightBlue",
        },
        DiagnosticHint = {
          fg = "LightGrey",
        },
        DiagnosticOk = {
          fg = "LightGreen",
        },
      },
    })
    -- keeps bottom diff intact
    nvim_set_hl(0, "GitSignsChange", { link = "DiffChange" })
  end,
}
