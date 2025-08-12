return {
  'lukas-reineke/indent-blankline.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    require('ibl').setup {
      indent = {
        char = '│',
        tab_char = '→',
      },
      scope = {
        enabled = false,
      },
    }
  end,
}
