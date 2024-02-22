return {
  'navarasu/onedark.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('onedark').setup {
      transparent = true,
    }

    vim.cmd.colorscheme 'onedark'

    vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'CursorLine', { underline = true, bg = 'none', fg = 'none' })
  end,
}
