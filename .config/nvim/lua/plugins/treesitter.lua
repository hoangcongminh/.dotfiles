return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  lazy = false,
  branch = 'main',
  dependencies = {},
  config = function()
    require 'custom.treesitter'
  end,
}
