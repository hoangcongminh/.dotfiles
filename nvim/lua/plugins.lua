vim.cmd [[packadd packer.nvim]]

vim.api.nvim_set_keymap('n','<leader>sy',"<cmd>PackerSync<cr>",{ noremap=true, silent=true })
vim.api.nvim_set_keymap('n','<leader>cl',"<cmd>PackerClean<cr>",{ noremap=true, silent=true })

return require('packer').startup(function()

use 'wbthomason/packer.nvim'

-- color Theme
use {'Mofiqul/vscode.nvim', branch = 'main', config = function ()
 require'color-scheme'
end}

-- treesitter
use {
  'nvim-treesitter/nvim-treesitter',
  run = ':TSUpdate',
  event = "BufWinEnter",
  config = function ()
    require'treesitter'
  end,
  requires = {
      {'nvim-treesitter/nvim-treesitter-textobjects',after = 'nvim-treesitter'},
      {'p00f/nvim-ts-rainbow', after = 'nvim-treesitter'}
  },
}
-- telescope
use {
  'nvim-telescope/telescope.nvim',
  requires = {
    'nvim-lua/plenary.nvim',
    {'nvim-telescope/telescope-fzf-native.nvim', run = 'make', after = 'telescope.nvim' ,config = function ()
	require('telescope').load_extension('fzf')
    end}
  },
  event = "BufEnter",
  config = function ()
    require'telescope-config'
  end,
}

-- floatTerm
use {'akinsho/toggleterm.nvim', config = function ()
  require'toggleterm-config'
end}

-- File and folder management
use {
  'kyazdani42/nvim-tree.lua',
  requires = 'kyazdani42/nvim-web-devicons',
  config = function ()
    require'nvimtree'
  end,
}

-- git
use 'tpope/vim-fugitive'
use {
  'lewis6991/gitsigns.nvim',
  config = function ()
    require'gitsigns-config'
  end,
  requires = {
    'nvim-lua/plenary.nvim'
  }
}

-- lualine & tabline
use {
  'nvim-lualine/lualine.nvim',
  event = "BufWinEnter",
  config = function ()
    require'lualine-config'
  end,
  requires = { 'kyazdani42/nvim-web-devicons', opt = true }
}
use {
  'romgrk/barbar.nvim',
  event = "BufWinEnter",
  config = function ()
    require'barbar-config'
  end,
  requires = {'kyazdani42/nvim-web-devicons'}
}

-- icons
use 'ryanoasis/vim-devicons'
use 'kyazdani42/nvim-web-devicons'

-- comment
use 'tpope/vim-commentary'

-- lsp
use {
    'neovim/nvim-lspconfig',
    config = function ()
      require'lsp-config'
    end,
}
use {'williamboman/nvim-lsp-installer'}
use {'j-hui/fidget.nvim', config = function ()
  require"fidget".setup{
    text = {
      spinner = "pipe",         -- animation shown when tasks are ongoing
      done = "✔",               -- character shown when all tasks are complete
      commenced = "Started",    -- message shown when task starts
      completed = "Completed",  -- message shown when task completes
    },
    window = {
      blend = 0,              -- &winblend for the window
    },
  }
end}
require('packer').use({
  'weilbith/nvim-code-action-menu',
  event = "BufWinEnter",
  cmd = 'CodeActionMenu',
  config = function ()
    vim.g.code_action_menu_window_border = 'none'
    vim.g.code_action_menu_show_details = false
    vim.g.code_action_menu_show_diff = false
  end,
})

-- flutter
use 'Nash0x7E2/awesome-flutter-snippets'
use {
  "akinsho/flutter-tools.nvim",
  requires = {
    "nvim-lua/plenary.nvim",
    'Nash0x7E2/awesome-flutter-snippets',
    'hrsh7th/cmp-nvim-lsp'
  },
  config = function ()
    require'flutter'
  end
}
use 'dart-lang/dart-vim-plugin'

-- completion
use {
  'hrsh7th/nvim-cmp',
  config = function ()
    require'cmp-config'
  end,
  requires = {
     {'hrsh7th/cmp-nvim-lsp', after='nvim-cmp'},
     {'hrsh7th/cmp-buffer', after='nvim-cmp'},
     {'hrsh7th/cmp-path', after='nvim-cmp'},
     {'hrsh7th/cmp-cmdline', after='nvim-cmp'},
     {'hrsh7th/cmp-vsnip', after='nvim-cmp'},
     {'hrsh7th/vim-vsnip', after='nvim-cmp'},
  }
}
use {'tzachar/cmp-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-cmp'}

-- snippets
use 'rafamadriz/friendly-snippets'

-- copilot
use {
  'github/copilot.vim',
  event = "BufWinEnter",
  config = function ()
    require'copilot'
  end
}

-- other
use 'tpope/vim-sleuth'
use 'tpope/vim-sensible'
use 'tpope/vim-surround'
use {'norcalli/nvim-colorizer.lua', config = function()
  require'colorizer'.setup()
end}
use {'windwp/nvim-autopairs', config = function()
  require('nvim-autopairs').setup({
    disable_filetype = { "TelescopePrompt" , "vim" },
  })
end}
use {'mg979/vim-visual-multi', branch = 'master'}

-- game??
use 'alec-gibson/nvim-tetris'

end)
