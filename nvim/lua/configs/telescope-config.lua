local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require('telescope.actions')
local telescope_builtin = require 'telescope.builtin'
local telescope_themes = require('telescope.themes')
local previewers = require("telescope.previewers")

local search_dotfiles = function()
  telescope_builtin.find_files({
    prompt_title = "< .dotfiles >",
    cwd = vim.env.DOTFILES,
    hidden = true,
    find_command = { 'rg', '--files', '--hidden', '-g', '!.git' },
  })
end

local project_files = function()
  local opts = {
    find_command = { 'fd', '--files', '--hidden', '-g', '!.git' },
  }
  vim.fn.system('git rev-parse --is-inside-work-tree')
  if vim.v.shell_error == 0 then
    require "telescope.builtin".git_files(opts)
  else
    require "telescope.builtin".find_files(opts)
  end
end

telescope.load_extension("fzf")
telescope.load_extension("ui-select")

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
  defaults = {
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
  pickers = {
    find_files = {
      theme = "ivy",
    },
    git_files = {
      theme = "ivy",
    }
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_cursor()
    },
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
    },
  }
}

local dropdown_theme = telescope_themes.get_dropdown();
local keymap = vim.keymap.set

local opts = { noremap = true, silent = true }

keymap('n', '<leader><leader>', function() project_files() end, opts)
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
keymap('n', '<leader>dff', function() search_dotfiles() end, opts)
