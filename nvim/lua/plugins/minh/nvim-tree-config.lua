local keymap_opts = { noremap = true, silent = true }

vim.keymap.set('n', '<leader>b', ":NvimTreeToggle<CR>", keymap_opts)
vim.keymap.set('n', '<leader>n', ":NvimTreeFindFile<CR>", keymap_opts)
vim.keymap.set('n', '<leader>r', ":NvimTreeRefresh<CR>", keymap_opts)

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    add_trailing = true,
    group_empty = true,
    highlight_git = true,
    full_name = true,
    indent_markers = {
      enable = true,
    },
    icons = {
      webdev_colors = true,
      git_placement = "before",
      padding = " ",
      symlink_arrow = " ➛ ",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          arrow_closed = "",
          arrow_open = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "U",
          deleted = "",
          ignored = "◌",
        },
      },
    },
    symlink_destination = true,
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },
  filters = {
    dotfiles = false,
  },
  actions = {
    open_file = {
      quit_on_open = true,
    },
  }
})
