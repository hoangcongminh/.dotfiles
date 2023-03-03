local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require('telescope.actions')
local telescope_themes = require('telescope.themes')
local previewers = require("telescope.previewers")

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

telescope.load_extension("fzf")
telescope.load_extension("ui-select")

pcall(telescope.load_extension, "smart_history")
pcall(telescope.load_extension, "frecency")
