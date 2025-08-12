return {
  { 'nvim-lua/plenary.nvim', lazy = true },
  { 'github/copilot.vim', event = 'InsertEnter' },

  {
    'numToStr/Comment.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('Comment').setup()
    end,
  },

  {
    'folke/todo-comments.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = { signs = false },
  },

  -- other
  { 'stevearc/dressing.nvim', lazy = true },
  { 'nvim-tree/nvim-web-devicons', lazy = true },

  { 'tpope/vim-sleuth', event = { 'BufReadPost', 'BufNewFile' } },
  { 'tpope/vim-surround', event = 'VeryLazy' },
  { 'tpope/vim-eunuch', lazy = true },
  { 'tpope/vim-dispatch', lazy = true },
  { 'mtdl9/vim-log-highlighting', event = { 'BufReadPost', 'BufNewFile' } },
}
