return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim", opts = { undercurl = true, transparent_mode = true } },

  -- Configure LazyVim to load gruvbox
  { "LazyVim/LazyVim", opts = { colorscheme = "gruvbox" } },

  -- disable lualine
  { "nvim-lualine/lualine.nvim", enabled = false },

  -- disable nvim-notify
  { "rcarriga/nvim-notify", enabled = false },

  -- set cmdlline to bottom
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      cmdline = {
        view = "cmdline", -- cmdline_popup || cmdline
      },
    },
  },
}
