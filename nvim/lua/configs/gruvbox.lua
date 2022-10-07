-- setup must be called before loading the colorscheme
-- Default options:
require("gruvbox").setup({
  undercurl = true,
  underline = true,
  bold = true,
  italic = true,
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "", -- can be "hard", "soft" or empty string
  overrides = {
    SignColumn = { bg = "none" },
    Cursorline = { bg = 'none' },
  },
  dim_inactive = false,
  transparent_mode = true,
})
vim.cmd([[
colorscheme gruvbox
highlight! CursorLine gui=underline cterm=underline guibg=none
]])