return {
  {
    'https://github.com/NeogitOrg/neogit',
    cmd = 'Neogit',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('neogit').setup {
        disable_commit_confirmation = true,
      }
    end,
  },

  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    keys = {
      { 'gn', '<cmd>Gitsigns next_hunk<cr>', desc = 'Next Git hunk' },
      { 'gN', '<cmd>Gitsigns prev_hunk<cr>', desc = 'Previous Git hunk' },
    },
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 300,
      },
      signcolumn = true, -- Hiển thị dấu hiệu Git trên cột
      numhl = false,
    },
  },
}
