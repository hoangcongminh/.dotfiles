-- netwr options
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.netrw_bufsettings = 'noma nomod nu nowrap ro nobl'

vim.opt.guicursor = ''
vim.opt.cursorline = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.wrap = false

vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.breakindent = true

vim.opt.scrolloff = 8

vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes'
vim.opt.colorcolumn = '80'
-- vim.opt.cmdheight = 0
vim.opt.laststatus = 3

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'

vim.opt.updatetime = 50

-- Trim ShaDa: keep marks/registers/jumplist short, skip search-history persist.
-- !  = uppercased globals; '100 = marks for 100 files; <50 = 50 lines/register;
-- s10 = 10 KB per item; h = no hlsearch persistence.
vim.opt.shada = "!,'100,<50,s10,h"

vim.opt.mouse = 'a'
