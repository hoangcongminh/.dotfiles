return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
  },
  config = function()
    local themes = require 'telescope.themes'
    require('telescope').setup {
      layout_strategy = 'horizontal', -- Faster than Ivy
      layout_config = { preview_cutoff = 120 }, -- Disable preview for small windows
      defaults = themes.get_ivy {
        preview = { treesitter = false },
      },
      path_display = { 'truncate' },
      sorting_strategy = 'ascending', -- Faster sorting
      extensions = {
        ['ui-select'] = {
          themes.get_ivy(),
        },
        fzf = {},
      },
      pickers = {
        find_files = {
          hidden = true,
          no_ignore = true,
          no_ignore_parent = true,
          file_ignore_patterns = { '.dart_tool/.*', 'node%_modules/.*' },
          find_command = { 'rg', '--files', '--hidden', '-g', '!.git' },
        },
      },
    }

    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    local builtin = require 'telescope.builtin'

    vim.keymap.set('n', '<leader><leader>', builtin.find_files)
    vim.keymap.set('n', '<leader>fp', builtin.git_files)
    vim.keymap.set('n', '<leader>fb', builtin.buffers)
    vim.keymap.set('n', '<leader>fo', builtin.oldfiles)
    vim.keymap.set('n', '<leader>qf', builtin.quickfix)
    vim.keymap.set('n', '<leader>fr', builtin.resume)
    vim.keymap.set('n', '<leader>lj', builtin.jumplist)
    vim.keymap.set('n', '<leader>ts', builtin.treesitter)
    vim.keymap.set('n', '<leader>fg', builtin.live_grep)
    vim.keymap.set('n', '<leader>/', function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end)

    vim.keymap.set('n', '<leader>qf', builtin.quickfix)
    vim.keymap.set('n', '<leader>gr', builtin.lsp_references)
    vim.keymap.set('n', '<leader>gd', builtin.lsp_definitions)
    vim.keymap.set('n', '<leader>ed', builtin.diagnostics)
  end,
}
