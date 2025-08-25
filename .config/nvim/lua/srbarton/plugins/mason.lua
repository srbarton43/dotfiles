return {
  "williamboman/mason.nvim",
  dependencies = { "williamboman/mason-lspconfig.nvim" },
  config = function ()
    require("mason").setup({
      ui = {
        border = "rounded"
      }
    })
  end
}
