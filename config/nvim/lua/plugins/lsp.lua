return {
  'neovim/nvim-lspconfig',
  event = "BufEnter",
  config = function()
    require('plugins.config.lsp')
  end
}
