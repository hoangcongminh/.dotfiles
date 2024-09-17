require('telescope').setup {
  defaults = {
    preview = {
      treesitter = false,
    },
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
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

local builtin = require 'telescope.builtin'

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
