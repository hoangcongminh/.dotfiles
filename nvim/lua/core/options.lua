-- netrw
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

local opt = vim.opt -- for conciseness

-- line numbers
opt.relativenumber = true
opt.number = true

-- tab & indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.shiftround = true
opt.expandtab = true

opt.smartindent = true
opt.autoindent = true

-- scroll
opt.scrolloff = 8
opt.sidescrolloff = 8

-- line wrapping
opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

-- cursor
opt.guicursor = ""
opt.cursorline = true
-- opt.cursorcolumn = true

-- appearance
opt.termguicolors = true
opt.signcolumn = "yes"
opt.colorcolumn = "80"

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append { 'unnamedplus' }

-- cmd
opt.laststatus = 3
-- opt.cmdheight = 0
opt.cmdheight = 1
opt.shortmess:append("c")

-- others
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

opt.updatetime = 50
opt.mouse = "a"
opt.completeopt = "menuone,noinsert,noselect"
opt.timeoutlen = 500 -- time to wait for a mapped sequence to complete (in milliseconds)
