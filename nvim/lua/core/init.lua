vim.opt.signcolumn = "yes"
vim.opt.cmdheight = 1
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.shiftround = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.swapfile = false
vim.opt.incsearch = true
vim.opt.cursorline = true
-- vim.opt.showmode = false
vim.opt.updatetime = 50
vim.opt.mouse = "a"

vim.opt.colorcolumn = "80"

vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = "menuone,noinsert,noselect"

vim.opt.shortmess:append("c")

-- Highlight on yank
vim.api.nvim_command('au TextYankPost * silent! lua vim.highlight.on_yank()')

-- Fotmat on save
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()]]
