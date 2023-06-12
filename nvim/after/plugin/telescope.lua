local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require('telescope.actions')
local previewers = require("telescope.previewers")
local telescope_themes = require('telescope.themes')
local telescope_builtin = require('telescope.builtin')
local dropdown_theme = telescope_themes.get_dropdown();

--Ignore files bigger than a threshold
local new_maker = function(filepath, bufnr, opts)
  opts = opts or {}
  filepath = vim.fn.expand(filepath)
  vim.loop.fs_stat(filepath, function(_, stat)
    if not stat then return end
    if stat.size > 100000 then
      return
    else
      previewers.buffer_previewer_maker(filepath, bufnr, opts)
    end
  end)
end

telescope.setup {
  defaults = telescope_themes.get_ivy {
    buffer_previewer_maker = new_maker,
    path_display = { "absolute" },
    igfile_ignore_patterns = { ".git/", "node_modules" },
    mappings = {
      i = {
        ["<C-q>"] = actions.send_to_qflist,
        ["<C-l>"] = actions.send_to_loclist,
        ['<C-r>'] = require('telescope.actions.layout').toggle_preview,
        ['<C-v>'] = actions.select_vertical,
        ['<C-s>'] = actions.select_horizontal,
      },
      n = {
        ["<C-w>"] = actions.send_selected_to_qflist,
        ["<C-q>"] = actions.send_to_qflist,
        ["<C-l>"] = actions.send_to_loclist,
        ['<C-r>'] = require('telescope.actions.layout').toggle_preview,
        ['<C-v>'] = actions.select_vertical,
        ['<C-s>'] = actions.select_horizontal,
        ['q'] = actions.close,
      },
    },
  },
  extensions = {
    ["ui-select"] = {
      telescope_themes.get_cursor()
    },
    fzf = {
      fuzzy = true,                   -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,    -- override the file sorter
      case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
    },
  },
  pickers = {
    find_files = {
      hidden = true,
      no_ignore = true,
      no_ignore_parent = true,
    },
    buffers = {
      sort_mru = true,
    },
  },
}

telescope.load_extension("fzf")
telescope.load_extension("ui-select")

pcall(telescope.load_extension, "smart_history")
pcall(telescope.load_extension, "frecency")

local opts = { noremap = true, silent = true }

local search_dotfiles = function()
  telescope_builtin.find_files({
    prompt_title = "~ .dotfiles ~",
    cwd = vim.env.DOTFILES,
    hidden = true,
    find_command = { 'rg', '--files', '--hidden', '-g', '!.git' },
  })
end

local project_files = function()
  local options = {
    find_command = { 'rg', '--files', '--hidden', '-g', '!.git' },
  }
  vim.fn.system('git rev-parse --is-inside-work-tree')
  if vim.v.shell_error == 0 then
    require "telescope.builtin".git_files(options)
  else
    require "telescope.builtin".find_files(options)
  end
end

vim.keymap.set('n', '<leader><leader>', project_files, opts)
vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, opts)
vim.keymap.set('n', '<leader>fp', telescope_builtin.git_files, opts)
vim.keymap.set('n', '<leader>s', telescope_builtin.current_buffer_fuzzy_find, opts)
vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, opts)
vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, opts)
vim.keymap.set('n', '<leader>fo', telescope_builtin.oldfiles, opts)
vim.keymap.set('n', '<leader>qf', telescope_builtin.quickfix, opts)
vim.keymap.set('n', '<leader>fr', telescope_builtin.resume, opts)
vim.keymap.set('n', '<leader>lj', telescope_builtin.jumplist, opts)
vim.keymap.set('n', '<leader>ts', telescope_builtin.treesitter, opts)

vim.keymap.set('n', '<leader>qf', function() telescope_builtin.quickfix(dropdown_theme) end, opts)
vim.keymap.set('n', '<leader>gr', function() telescope_builtin.lsp_references(dropdown_theme) end, opts)
vim.keymap.set('n', '<leader>gd', function() telescope_builtin.lsp_definitions(dropdown_theme) end, opts)
vim.keymap.set('n', '<leader>ed', function() telescope_builtin.diagnostics(dropdown_theme) end, opts)

vim.keymap.set('n', '<leader>t', function() vim.cmd 'Telescope' end, opts)
vim.keymap.set('n', '<leader>dff', search_dotfiles, opts)
