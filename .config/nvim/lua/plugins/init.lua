return {
  { 'nvim-lua/plenary.nvim', lazy = true },
  {
    'zbirenbaum/copilot.lua',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        suggestion = { enabled = true, auto_trigger = true },
        panel = { enabled = false },
      }
    end,
  },

  {
    'folke/todo-comments.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = { signs = false },
  },

  -- other
  { 'stevearc/dressing.nvim', event = 'VeryLazy' },
  { 'nvim-tree/nvim-web-devicons', lazy = true },

  { 'tpope/vim-sleuth', event = { 'BufReadPost', 'BufNewFile' } },
  {
    'kylechui/nvim-surround',
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup {}
    end,
  },
  { 'tpope/vim-eunuch', lazy = true },
  { 'tpope/vim-dispatch', lazy = true },
  { 'mtdl9/vim-log-highlighting', event = { 'BufReadPost', 'BufNewFile' } },
}
