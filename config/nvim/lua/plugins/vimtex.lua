return {
  'lervag/vimtex',
  event = "BufEnter *.tex",
  dependencies = {
    'ckunte/latex-snippets-vim',
    'srbarton43/luasnip-latex-snippets.nvim',
    config = function()
      require'luasnip-latex-snippets'.setup()
    end,
  },
  config = function()
    require('plugins.config.vimtex')
  end
}
