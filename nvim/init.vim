" => VIMPLUG <=
call plug#begin('~/.dotfiles/nvim/plugged')
" File and folder management
" Plug 'kyazdani42/nvim-tree.lua'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
call plug#end()

luafile ~/.dotfiles/nvim/settings.lua
luafile ~/.dotfiles/nvim/keymaps.lua
