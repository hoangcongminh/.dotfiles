-- vim.cmd.colorscheme("rose-pine")
vim.opt.background = "dark"

-- Custom winbar
vim.o.winbar =
	"%m%y " ..
	"%{%v:lua.require'nvim-web-devicons'.get_icon_color_by_filetype(&filetype)%} " ..
	"%f"

-- Custom statusline
vim.opt.laststatus = 3
vim.opt.statusline =
	"%#Substitute# %Y %0*" .. -- filetype
	" %f " ..              -- path to file
	"%m" ..                -- modifed
	"%r" ..                -- readonly
	"%=" ..                -- separator
	" %{&fileencoding} " .. -- file encoding
	"|" ..                 -- padding
	" %{&fileformat} " ..  -- file format
	"|" ..                 -- padding
	" %c:%l/%L "           -- column at line per total lines

vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "ColorColumn", { ctermbg = 0, bg = "#333333" })
vim.api.nvim_set_hl(0, "CursorLine", { underline = true, bg = "none", fg = "none" })
vim.api.nvim_set_hl(0, "CursorLineNR", { bg = "none" })