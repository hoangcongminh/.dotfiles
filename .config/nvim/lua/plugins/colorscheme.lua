return {
  'folke/tokyonight.nvim',
  priority = 1000,
  opts = {},
  config = function()
    require('tokyonight').setup {
      transparent = true,
    }
    vim.cmd.colorscheme 'tokyonight-storm'

    vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'CursorLine', { underline = true, bg = 'none', fg = 'none' })
  end,
}
