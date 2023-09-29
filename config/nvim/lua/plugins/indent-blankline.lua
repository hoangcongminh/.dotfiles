return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("ibl").setup({
      char = "┊",
      show_current_context = true,
      show_first_indent_level = false,
      show_trailing_blankline_indent = false,
      use_treesitter = true,
    })
  end,
}
