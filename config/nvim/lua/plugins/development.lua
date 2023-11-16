return {
  -- specify a commit for treesitter which not conflict with dartlang
  { "nvim-treesitter/nvim-treesitter", commit = "33eb472b459f1d2bf49e16154726743ab3ca1c6d" },

  -- flutter development
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    config = true,
  },
}
