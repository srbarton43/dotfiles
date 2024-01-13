return {
  'L3MON4D3/LuaSnip',
  event = 'InsertEnter',
  version = "v2.*",
  build = 'make install_jsregexp',
  config = function()
    require("plugins.config.luasnip")
  end
}
  
