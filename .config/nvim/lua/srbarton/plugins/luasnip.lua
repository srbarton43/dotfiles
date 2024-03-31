return {
  'L3MON4D3/LuaSnip',
  event = 'InsertEnter',
  version = "v2.*",
  build = 'make install_jsregexp',
  config = function()
    require("luasnip").setup({
      history = true, -- keep around last snippet local to jump back
      enable_autosnippets = true,
      store_selection_keys = "<Tab>",
    })
    require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/LuaSnip/" })
  end
}
