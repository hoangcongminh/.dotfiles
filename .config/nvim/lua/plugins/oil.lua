return {
  'https://github.com/stevearc/oil.nvim',
  cmd = 'Oil',
  keys = {
    { '<leader>pv', '<CMD>Oil<CR>', desc = 'Open parent directory' },
  },
  config = function()
    require('oil').setup {
      columns = {
        'icon',
        -- 'permissions',
        -- 'size',
        -- 'mtime',
      },
      view_options = {
        show_hidden = true,
      },
    }
  end,
}
