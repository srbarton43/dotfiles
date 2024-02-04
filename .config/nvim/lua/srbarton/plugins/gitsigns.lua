return {
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup({
      numhl = false, -- color numbers along with signs to left
    })
  end
}
