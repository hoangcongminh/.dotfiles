vim.opt.background = "dark"
vim.o.winbar = "%m%y " .. "%{%v:lua.require'nvim-web-devicons'.get_icon_color_by_filetype(&filetype)%} " .. "%f"

vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "ColorColumn", { ctermbg = 0, bg = "#333333" })
vim.api.nvim_set_hl(0, "CursorLine", { underline = true, bg = "none", fg = "none" })
vim.api.nvim_set_hl(0, "CursorLineNR", { bg = "none" })

vim.cmd.colorscheme(require("global").coloscheme)
