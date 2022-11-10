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
opt.incsearch = true

-- cursor
opt.cursorline = true
-- opt.cursorcolumn = true

-- appearance
vim.o.winbar = "%m%y %{%v:lua.require'nvim-web-devicons'.get_icon_color_by_filetype(&filetype)%} %f > %{%v:lua.require'nvim-navic'.get_location()%}"
opt.termguicolors = true
opt.signcolumn = "yes"
-- opt.colorcolumn = "80"

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append { 'unnamedplus' }

-- split windows
opt.splitright = true
opt.splitbelow = true

-- cmd
opt.laststatus = 3
-- opt.cmdheight = 0
opt.cmdheight = 1
opt.shortmess:append("c")

-- others
opt.swapfile = false
opt.updatetime = 50
opt.mouse = "a"
opt.completeopt = "menuone,noinsert,noselect"
