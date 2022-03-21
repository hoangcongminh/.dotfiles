vim.cmd([[
  set completeopt=menu,menuone,noselect
  set signcolumn=yes
  set numberwidth=4
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
  set mouse=a "enable mouse for all mode

  so ~/.dotfiles/nvim/color-scheme.vim
]])
