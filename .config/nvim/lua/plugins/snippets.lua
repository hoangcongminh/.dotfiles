return {
  'L3MON4D3/LuaSnip',
  event = 'InsertEnter',
  version = 'v2.*',
  build = 'make install_jsregexp',
  dependencies = { 'rafamadriz/friendly-snippets' },
  config = function()
    local ls = require 'luasnip'

    require('luasnip.loaders.from_vscode').lazy_load()

    local custom_snippets_path = './snippets'
    if vim.fn.isdirectory(custom_snippets_path) == 1 then
      require('luasnip.loaders.from_vscode').lazy_load { paths = custom_snippets_path }
    end
    ls.filetype_extend('dart', { 'flutter' })
  end,
}
