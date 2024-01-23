return {
  'jdhao/better-escape.vim',
  event = "InsertEnter",
  config = function()
    vim.g['better_escape_shortcut'] = {'jk', 'kj', 'JK', 'KJ'}
  end
}
