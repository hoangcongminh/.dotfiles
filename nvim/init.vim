" => VIMPLUG <=
call plug#begin('~/.dotfiles/nvim/plugged')
" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'p00f/nvim-ts-rainbow'
" FloatTerm
Plug 'akinsho/toggleterm.nvim'
" File and folder management
Plug 'kyazdani42/nvim-tree.lua'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'natebosch/dartlang-snippets'
" Language support
Plug 'jiangmiao/auto-pairs'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Dart
Plug 'dart-lang/dart-vim-plugin'
" Color Scheme 
Plug 'pineapplegiant/spaceduck', { 'branch': 'main' }
Plug 'EdenEast/nightfox.nvim'
Plug 'morhetz/gruvbox'
Plug 'Mofiqul/vscode.nvim'
Plug 'eddyekofo94/gruvbox-flat.nvim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
" Icons
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
" Git
Plug 'tpope/vim-fugitive'
" GitSigns
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'
" statusline and tabline
Plug 'nvim-lualine/lualine.nvim'
" Comment
Plug 'tpope/vim-commentary'
" Copilot
Plug 'github/copilot.vim'
" Multiple Cursors
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

"Other
Plug 'tpope/vim-surround'
call plug#end()

" always show the signcolumn
autocmd BufRead,BufNewFile * setlocal signcolumn=yes
" remove the color from the signColumn
autocmd BufRead,BufNewFile * highlight clear SignColumn

luafile ~/.dotfiles/nvim/settings.lua
luafile ~/.dotfiles/nvim/keymaps.lua
luafile ~/.dotfiles/nvim/treesitter.lua
luafile ~/.dotfiles/nvim/toggleterm.lua
luafile ~/.dotfiles/nvim/nvimtree.lua
luafile ~/.dotfiles/nvim/gitsigns.lua
luafile ~/.dotfiles/nvim/lualine.lua

so ~/.dotfiles/nvim/color-scheme.vim
so ~/.dotfiles/nvim/coc-config.vim
