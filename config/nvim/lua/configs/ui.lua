local global = require("global")

require("tokyonight").setup({
	style = "moon",
	transparent = global.transparent,
})

require("everforest").setup({
	transparent_background_level = 1,
	italics = true,
})

require("rose-pine").setup({
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
})

vim.cmd.colorscheme(global.coloscheme)
vim.opt.background = "dark"
vim.o.winbar = "%m%y " .. "%{%v:lua.require'nvim-web-devicons'.get_icon_color_by_filetype(&filetype)%} " .. "%f"

vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "ColorColumn", { ctermbg = 0, bg = "#333333" })
vim.api.nvim_set_hl(0, "CursorLine", { underline = true, bg = "none", fg = "none" })
vim.api.nvim_set_hl(0, "CursorLineNR", { bg = "none" })
