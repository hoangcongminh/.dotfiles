return {
  'rose-pine/neovim',
  name = 'rose-pine',
  priority = 1000,
  opts = {},
  config = function()
    require('rose-pine').setup {
      variant = 'moon', -- auto, main, moon, or dawn
      styles = {
        transparency = true,
      },
    }
    vim.cmd.colorscheme 'rose-pine-moon'

    vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'CursorLine', { underline = true, bg = 'none', fg = 'none' })
  end,
}
