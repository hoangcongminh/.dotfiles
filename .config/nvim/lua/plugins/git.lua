return {
  {
    'https://github.com/NeogitOrg/neogit',
    cmd = 'Neogit',
    config = function()
      require('neogit').setup {
        disable_commit_confirmation = true,
      }
    end,
  },

  {
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    keys = {
      { 'gn', '<cmd>Gitsigns next_hunk<cr>' },
      { 'gp', '<cmd>Gitsigns prev_hunk<cr>' },
    },
    config = function()
      require('gitsigns').setup {
        current_line_blame = true,
      }
    end,
  },
}
