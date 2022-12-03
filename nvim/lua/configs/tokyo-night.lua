local ok, tokyonight = pcall(require, "tokyonight")
if not ok then
  return
end

tokyonight.setup({
  style = "storm",
  light_style = "day",
  transparent = true,
  terminal_colors = true,
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    functions = {},
    variables = {},
    sidebars = "transparent",
    floats = "dark",
  },
  sidebars = { "qf", "vista_kind", "terminal", "packer" },
  day_brightness = 0.3,
  hide_inactive_statusline = false,
  dim_inactive = false,
  lualine_bold = false,

  on_colors = function(colors) end,
  on_highlights = function(highlights, colors) end,
})
