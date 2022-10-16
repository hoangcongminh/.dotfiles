vim.o.winbar = "%m%y %f > %{%v:lua.require'nvim-navic'.get_location()%}"
vim.opt.signcolumn = "yes"
vim.opt.laststatus = 3
vim.opt.cmdheight = 1
-- vim.opt.laststatus = 0
vim.opt.cmdheight = 0
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
-- vim.opt.cursorcolumn = true
vim.opt.cursorline = true
vim.opt.showmode = false
vim.opt.updatetime = 50
vim.opt.mouse = "a"
-- vim.opt.colorcolumn = "80"
-- vim.opt.clipboard = "unnamedplus"
vim.opt.clipboard:append { 'unnamedplus' }
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.shortmess:append("c")

-- Unset relativenumber in insert mode
vim.cmd("au InsertEnter * set norelativenumber")
vim.cmd("au InsertLeave * set relativenumber")

-- Unset paste mode when leaving insert mode
vim.cmd("au InsertLeave * set nopaste")

-- Set colorscheme
require 'configs.catppuccin'
