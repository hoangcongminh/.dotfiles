return {
  {
    'nvim-lua/plenary.nvim',
    lazy = true,
  },

  { 'github/copilot.vim' },

  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'VeryLazy',
    config = function()
      require('ibl').setup {
        indent = {
          char = '▏',
          tab_char = '▏',
        },
        scope = {
          enabled = false,
        },
      }
    end,
  },

  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
  },

  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      require('nvim-autopairs').setup()
    end,
  },

  {
    'numToStr/Comment.nvim',
    event = 'VeryLazy',
    config = function()
      require('Comment').setup()
    end,
  },

  {
    'folke/todo-comments.nvim',
    cmd = { 'TodoTrouble', 'TodoTelescope' },
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {},
  },

  -- other
  { 'ryanoasis/vim-devicons' },
  { 'kyazdani42/nvim-web-devicons' },

  { 'tpope/vim-sleuth', event = 'VeryLazy' },
  { 'tpope/vim-surround', event = 'VeryLazy' },
  { 'tpope/vim-eunuch', event = 'VeryLazy' },
  { 'tpope/vim-dispatch', event = 'VeryLazy' },

  { 'mtdl9/vim-log-highlighting', event = 'VeryLazy' },
}
