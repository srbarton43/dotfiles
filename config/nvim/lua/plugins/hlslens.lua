return {
   "kevinhwang91/nvim-hlslens",
   branch = "main",
   event = "BufEnter",
   keys = { { "n", "*" }, { "n", "#" }, { "n", "n" }, { "n", "N" } },
   config = function()
     require('plugins.config.hlslens')
   end
}
