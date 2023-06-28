require("nvim-treesitter.configs").setup {
  ensure_installed = { "python", "c", "rust", "cpp", "lua", "vim","norg","query", "latex" },
  ignore_install = {}, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { 'help', 'latex' }, -- list of language that will be disabled
  },
}
