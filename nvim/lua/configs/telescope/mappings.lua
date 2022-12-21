local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local functions = require('configs.telescope.functions')

local telescope_builtin = require('telescope.builtin')
local telescope_themes = require('telescope.themes')

local dropdown_theme = telescope_themes.get_dropdown();
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap('n', '<leader><leader>', functions.project_files, opts)
keymap('n', '<leader>ff', telescope_builtin.find_files, opts)
keymap('n', '<leader>fp', telescope_builtin.git_files, opts)
keymap('n', '<space>s', telescope_builtin.current_buffer_fuzzy_find, opts)
keymap('n', '<space>fg', telescope_builtin.live_grep, opts)
keymap('n', '<space>fb', telescope_builtin.buffers, opts)
keymap('n', '<space>fo', telescope_builtin.oldfiles, opts)
keymap('n', '<space>qf', telescope_builtin.quickfix, opts)
keymap('n', '<space>fr', telescope_builtin.resume, opts)
keymap('n', '<space>lj', telescope_builtin.jumplist, opts)
keymap('n', '<space>ts', telescope_builtin.treesitter, opts)

keymap('n', '<space>qf', function() telescope_builtin.quickfix(dropdown_theme) end, opts)
keymap('n', '<space>gr', function() telescope_builtin.lsp_references(dropdown_theme) end, opts)
keymap('n', '<space>gd', function() telescope_builtin.lsp_definitions(dropdown_theme) end, opts)
keymap('n', '<space>fd', function() telescope_builtin.diagnostics(dropdown_theme) end, opts)

keymap('n', '<space>t', function() vim.cmd 'Telescope' end, opts)
keymap('n', '<leader>dff', functions.search_dotfiles, opts)
keymap('n', '<leader>bm', function() telescope.extensions.bookmarks.bookmarks(telescope_themes.get_ivy()) end, opts)
