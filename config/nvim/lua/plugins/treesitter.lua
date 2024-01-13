return {
  "nvim-treesitter/nvim-treesitter",
  version = "v0.9.1",
  event = "BufEnter",
  build = ":TSUpdate",
  config = function()
    require('plugins.config.treesitter')
  end
}
