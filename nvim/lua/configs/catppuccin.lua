vim.g.catppuccin_flavour = "frappe" -- latte, frappe, macchiato, mocha
local colors = require("catppuccin.palettes").get_palette()
colors.none = "NONE"

require("catppuccin").setup({ transparent_background = true,
  term_colors = true,
  compile = {
    enabled = true,
    path = vim.fn.stdpath("cache") .. "/catppuccin",
  },
  dim_inactive = {
    enabled = false,
    shade = "dark",
    percentage = 0.15,
  },
  styles = {
    comments = { "italic" },
    conditionals = { "italic" },
    loops = {},
    functions = {},
    keywords = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
  },
  integrations = {
    -- For various plugins integrations see https://github.com/catppuccin/nvim#integrations
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
      },
    },
  },
  color_overrides = {},
  highlight_overrides = {},
  custom_highlights = {
    Comment = { fg = colors.overlay1 },
    LineNr = { fg = colors.overlay1 },
    CursorLine = { bg = colors.none },
    CursorLineNr = { fg = colors.lavender },
    DiagnosticVirtualTextError = { bg = colors.none },
    DiagnosticVirtualTextWarn = { bg = colors.none },
    DiagnosticVirtualTextInfo = { bg = colors.none },
    DiagnosticVirtualTextHint = { bg = colors.none },
  }
})

vim.cmd [[
  colorscheme catppuccin
  hi! CursorLine gui=underline cterm=underline guibg=none
]]
