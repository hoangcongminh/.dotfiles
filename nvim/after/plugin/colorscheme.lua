local status_ok, rose_pine = pcall(require, "rose-pine")
if not status_ok then
    return
end

rose_pine.setup({
    disable_background = true
})

vim.opt.background = "dark"
vim.o.winbar = "%m%y " ..
    "%{%v:lua.require'nvim-web-devicons'.get_icon_color_by_filetype(&filetype)%} " ..
    "%f > " ..
    "%{%v:lua.require'nvim-navic'.get_location()%}"
vim.cmd.colorscheme("rose-pine")

vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "ColorColumn", { ctermbg = 0, bg = "#333333" })
vim.api.nvim_set_hl(0, "CursorLine", { underline = true, bg = "none", fg = "none" })
vim.api.nvim_set_hl(0, "CursorLineNR", { bg = "none" })
