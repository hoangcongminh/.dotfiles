return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  lazy = false,
  build = ':CatppuccinCompile',
  config = function()
    require('catppuccin').setup({
      flavour = 'mocha',
      transparent_background = true,
      compile_path = vim.fn.stdpath('cache') .. '/catppuccin',
    })

    vim.cmd.colorscheme 'catppuccin'

    vim.api.nvim_set_hl(0, 'CursorLine', { underline = true, bg = 'none', fg = 'none' })
  end,
}
