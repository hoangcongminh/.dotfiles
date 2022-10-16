local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require('telescope.actions')
-- local fb_actions = require "telescope".extensions.file_browser.actions


local search_dotfiles = function()
  require("telescope.builtin").find_files({
    prompt_title = "< .dotfiles >",
    cwd = vim.env.DOTFILES,
    hidden = true,
    find_command = { 'rg', '--files', '--hidden', '-g', '!.git' },
  })
end

-- local project_files = function()
--   local opts = {
--     previewer = false
--   } -- define here if you want to define something
--   local ok = pcall(require "telescope.builtin".git_files)
--   if not ok then require "telescope.builtin".find_files({ find_command = { 'rg', '--files', '--hidden', '-g', '!.git' },
--       previewer = false })
--   end
-- end

telescope.setup {
  igfile_ignore_patterns = { "node_modules" },
  pickers = {
    find_files = {
      hidden = true
    }
  },
  defaults = {
    mappings = {
      i = {
        ["<C-q>"] = actions.send_to_qflist,
        ["<C-l>"] = actions.send_to_loclist,
        ['<C-r>'] = require('telescope.actions.layout').toggle_preview
      },
      n = {
        ["<C-w>"] = actions.send_selected_to_qflist,
        ["<C-q>"] = actions.send_to_qflist,
        ["<C-l>"] = actions.send_to_loclist,
        ['<C-r>'] = require('telescope.actions.layout').toggle_preview
      },
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_cursor()
    },
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = false, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
    },
    -- file_browser = {
    --   theme = "ivy",
    --   -- disables netrw and use telescope-file-browser in its place
    --   hijack_netrw = true,
    --   mappings = {
    --     ["i"] = {
    --       -- your custom insert mode mappings
    --     },
    --     ["n"] = {
    --       -- your custom normal mode mappings
    --     },
    --   },
    -- },
  }
}

local dropdown_theme = require('telescope.themes').get_dropdown();
local telescope_builtin = require 'telescope.builtin'
local keymap = vim.keymap.set

local opts = { noremap = true, silent = true }

-- keymap('n', '<space>P',
--   function()
--     telescope_builtin.find_files({ find_command = { 'rg', '--files', '--hidden', '-g', '!.git' }, previewer = false })
--   end,
--   opts
-- )
-- keymap('n', '<space>p', function() telescope_builtin.git_files({ previewer = false }) end, opts)
--
-- keymap('n', '<leader>p', function() project_files() end, opts)
-- keymap('n', '<leader>ff',
--   function() require "telescope.builtin".find_files({ find_command = { 'rg', '--files', '--hidden', '-g', '!.git' },
--       previewer = false })
--   end, opts)
keymap('n', '<leader>p',
  function() require "telescope.builtin".find_files({ find_command = { 'rg', '--files', '--hidden', '-g', '!.git' },
      previewer = false })
  end, opts)

keymap('n', '<space>fg', telescope_builtin.live_grep, opts)
keymap('n', '<space>fb', telescope_builtin.buffers, opts)
keymap('n', '<space>fo', telescope_builtin.oldfiles, opts)
keymap('n', '<space>qf', telescope_builtin.quickfix, opts)
keymap('n', '<space>fr', telescope_builtin.resume, opts)
keymap('n', '<space>lj', telescope_builtin.jumplist, opts)
keymap('n', '<space>ts', telescope_builtin.treesitter, opts)

keymap('n', '<space>qf', function() telescope_builtin.quickfix(dropdown_theme) end, opts)
keymap('n', '<space>gr', function() telescope_builtin.lsp_references(dropdown_theme) end, opts)
-- keymap('n', '<space>gd', function() telescope_builtin.lsp_definitions(dropdown_theme) end, opts)
keymap('n', '<space>fd', function() telescope_builtin.diagnostics(dropdown_theme) end, opts)

keymap('n', '<space>t', function() vim.cmd 'Telescope' end, opts)
keymap('n', '<leader>dff', function() search_dotfiles() end, opts)
-- keymap('n', '<leader>b', ":Telescope file_browser<CR>", opts)
