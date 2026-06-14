return {
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
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
  keys = {
    { '<leader><leader>', function() require('telescope.builtin').find_files() end,    desc = 'Find files' },
    { '<leader>fp',       function() require('telescope.builtin').git_files() end,     desc = 'Git files' },
    { '<leader>fb',       function() require('telescope.builtin').buffers() end,       desc = 'Buffers' },
    { '<leader>fo',       function() require('telescope.builtin').oldfiles() end,      desc = 'Oldfiles' },
    { '<leader>qf',       function() require('telescope.builtin').quickfix() end,      desc = 'Quickfix' },
    { '<leader>fr',       function() require('telescope.builtin').resume() end,        desc = 'Resume' },
    { '<leader>lj',       function() require('telescope.builtin').jumplist() end,      desc = 'Jumplist' },
    { '<leader>ts',       function() require('telescope.builtin').treesitter() end,    desc = 'Treesitter symbols' },
    { '<leader>fg',       function() require('telescope.builtin').live_grep() end,     desc = 'Live grep' },
    { '<leader>/',        function()
        require('telescope.builtin').current_buffer_fuzzy_find(
          require('telescope.themes').get_dropdown { winblend = 10, previewer = false }
        )
      end, desc = 'Fuzzy current buffer' },
    { '<leader>gr',       function() require('telescope.builtin').lsp_references() end,  desc = 'LSP references' },
    { '<leader>gd',       function() require('telescope.builtin').lsp_definitions() end, desc = 'LSP definitions' },
    { '<leader>ed',       function() require('telescope.builtin').diagnostics() end,     desc = 'Diagnostics' },
  },
  config = function()
    local themes = require 'telescope.themes'
    require('telescope').setup {
      layout_strategy = 'horizontal',
      layout_config = { preview_cutoff = 120 },
      defaults = themes.get_ivy {
        preview = { treesitter = false },
      },
      path_display = { 'truncate' },
      sorting_strategy = 'ascending',
      extensions = {
        ['ui-select'] = {
          themes.get_ivy(),
        },
        fzf = {},
      },
      pickers = {
        find_files = {
          hidden = true,
          file_ignore_patterns = { '.dart_tool/.*', 'node%_modules/.*' },
        },
      },
    }

    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
  end,
}
