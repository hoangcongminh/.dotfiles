return {
  'nvim-telescope/telescope.nvim',
  event = 'VeryLazy',
  branch = '0.1.x',
  dependencies = {
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
  },
  config = function()
    local builtin = require 'telescope.builtin'

    require('telescope').setup {
      extensions = {
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
        },
      },
      pickers = {
        find_files = {
          hidden = true,
          no_ignore = true,
          no_ignore_parent = true,
          find_command = { 'rg', '--files', '--hidden', '-g', '!.git' },
        },
      },
    }

    require('telescope').load_extension 'fzf'

    vim.keymap.set('n', '<leader><leader>', builtin.find_files)
    vim.keymap.set('n', '<leader>fp', builtin.git_files)
    vim.keymap.set('n', '<leader>s', builtin.current_buffer_fuzzy_find)
    vim.keymap.set('n', '<leader>fg', builtin.live_grep)
    vim.keymap.set('n', '<leader>fb', builtin.buffers)
    vim.keymap.set('n', '<leader>fo', builtin.oldfiles)
    vim.keymap.set('n', '<leader>qf', builtin.quickfix)
    vim.keymap.set('n', '<leader>fr', builtin.resume)
    vim.keymap.set('n', '<leader>lj', builtin.jumplist)
    vim.keymap.set('n', '<leader>ts', builtin.treesitter)

    vim.keymap.set('n', '<leader>qf', builtin.quickfix)
    vim.keymap.set('n', '<leader>gr', builtin.lsp_references)
    vim.keymap.set('n', '<leader>gd', builtin.lsp_definitions)
    vim.keymap.set('n', '<leader>ed', builtin.diagnostics)
  end,
}
