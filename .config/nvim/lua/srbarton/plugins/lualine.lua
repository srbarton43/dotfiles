return {
  'nvim-lualine/lualine.nvim',
  event = { "BufReadPost", "BufNewFile" },
  dependencies = { 'nvim-tree/nvim-web-devicons', },
  config = function()
    require('lualine').setup({
      options = {
        section_separators = { left = '', right = ''},
        component_separators = { left = '', right = ''},
      }
    })
  end
}
