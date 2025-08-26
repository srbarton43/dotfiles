return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup {
      ensure_installed = { "python", "c", "rust", "cpp", "lua", "vim", "latex", "matlab" },
      ignore_install = {},        -- List of parsers to ignore installing
      highlight = {
        enable = true,            -- false will disable the whole extension
        disable = { 'help', 'latex' }, -- list of language that will be disabled
      },
    }
  end
}
