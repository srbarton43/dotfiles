return {
  'hrsh7th/nvim-cmp',
  event = "InsertEnter",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-omni",
    "saadparwaiz1/cmp_luasnip",
    "neovim/nvim-lspconfig",
    "L3MON4D3/LuaSnip",
    "onsails/lspkind-nvim",
    "hrsh7th/cmp-cmdline",
  },
  config = function()
    require('plugins.config.nvim-cmp')
  end,
}
