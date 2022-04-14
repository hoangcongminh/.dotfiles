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

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 100})
augroup END

let g:dart_style_guide = 2
let g:dart_format_on_save = 1
]])
