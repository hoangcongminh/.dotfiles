vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()

use 'wbthomason/packer.nvim'

-- color Theme
use {'Mofiqul/vscode.nvim', branch = 'main'}
  
-- treesitter
use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
use 'nvim-treesitter/nvim-treesitter-textobjects'
use 'p00f/nvim-ts-rainbow'

-- telescope
use {
  'nvim-telescope/telescope.nvim',
  requires = { {'nvim-lua/plenary.nvim'} },
}
use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

-- floatTerm
use 'akinsho/toggleterm.nvim'

-- File and folder management
use 'kyazdani42/nvim-tree.lua'

-- git 
use 'tpope/vim-fugitive'
use {
  'lewis6991/gitsigns.nvim',
  requires = {
    'nvim-lua/plenary.nvim'
  },
}

-- lualine
use {
  'nvim-lualine/lualine.nvim',
  requires = { 'kyazdani42/nvim-web-devicons', opt = true }
}

-- icons
use 'ryanoasis/vim-devicons'
use 'kyazdani42/nvim-web-devicons'

-- comment
use 'tpope/vim-commentary'

-- lsp 
use 'neovim/nvim-lspconfig'

-- completion
use 'hrsh7th/cmp-nvim-lsp'
use 'hrsh7th/cmp-buffer'
use 'hrsh7th/cmp-path'
use 'hrsh7th/cmp-cmdline'
use 'hrsh7th/nvim-cmp'

use 'hrsh7th/cmp-vsnip'
use 'hrsh7th/vim-vsnip'
use {'tzachar/cmp-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-cmp'}

-- flutter
use 'Nash0x7E2/awesome-flutter-snippets'
use {
  "akinsho/flutter-tools.nvim",
  requires = "nvim-lua/plenary.nvim",
}
use 'windwp/lsp-fastaction.nvim'

-- copilot
use 'github/copilot.vim'

-- other
use 'tpope/vim-surround'
use {
  'windwp/nvim-autopairs', 
  config = function()
    require('nvim-autopairs').setup({
      disable_filetype = { "TelescopePrompt" , "vim" },
    })
  end
}
use {'mg979/vim-visual-multi', branch = 'master'}

end)
