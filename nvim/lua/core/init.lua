-- vim.notify = require("notify")

vim.cmd([[
  set completeopt=menu,menuone,noselect
  set signcolumn=yes
  set clipboard+=unnamedplus 
  set cmdheight=2 
  set noshowmode 
  set termguicolors 
  set number 
  set relativenumber 
  set smartindent 
  set smartcase 
  set ignorecase 
  set scrolloff=8 
  set sidescrolloff=8 
  set softtabstop=2 
  set shiftwidth=2 
  set shiftround 
  set cursorline 
  set noswapfile 
  set incsearch
  set mouse=a "enable mouse for all mode
]])
-- Auto commands
vim.api.nvim_command('au TextYankPost * silent! lua vim.highlight.on_yank()')

-- Fotmat on save
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()]]
