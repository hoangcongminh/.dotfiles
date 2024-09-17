return {
  'rose-pine/neovim',
  name = 'rose-pine',
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
    require('rose-pine').setup {
      styles = {
        bold = true,
        italic = true,
        transparency = true,
      },
    }

    vim.cmd 'colorscheme rose-pine-moon'

    require 'custom.ui'
  end,
}
