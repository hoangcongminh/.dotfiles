local global = require("global")

return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    config = function()
      require("tokyonight").setup({
        style = "moon",
        transparent = global.transparent,
      })
    end,
  },
  {
    "rose-pine/neovim",
    lazy = true,
    name = "rose-pine",
    priority = 1000,
    opts = {
      --- @usage 'auto'|'main'|'moon'|'dawn'
      variant = "auto",
      --- @usage 'main'|'moon'|'dawn'
      dark_variant = "main",
      bold_vert_split = false,
      dim_nc_background = false,
      disable_background = true,
      disable_float_background = false,
      disable_italics = false,
      transparent = global.transparent,
    },
  },
  {
    "neanias/everforest-nvim",
    lazy = true,
    version = false,
    priority = 1000,
    config = function()
      require("everforest").setup({
        transparent_background_level = 1,
        italics = true,
      })
    end,
  },
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      transparent = global.transparent,
    },
  },
}
