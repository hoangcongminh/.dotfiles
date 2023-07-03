return {
  'L3MON4D3/LuaSnip',
  event = "VeryLazy",
  dependencies = { 'rafamadriz/friendly-snippets' },
  config = function()
    local ls = require('luasnip')

    require("luasnip.loaders.from_vscode").lazy_load()
    require('luasnip.loaders.from_vscode').lazy_load({ paths = './snippets' })
    ls.filetype_extend('dart', { 'flutter' })
  end,
}
