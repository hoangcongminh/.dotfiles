-- Auto install plugin manager
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd.packadd('packer.nvim')
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

-- Automatically source and re-compile packer whenever you save this plugins.lua
local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	command = "source <afile> | PackerCompile",
	group = packer_group,
	pattern = vim.fn.expand("plugins.lua"),
})

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "single" })
		end,
	},
	git = {
		clone_timeout = 600, -- Timeout, in seconds, for git clones
	},
	max_jobs = 10,
	luarocks = {
		python_cmd = 'python3' -- Set the python command to use for running hererocks
	},
})

-- Plugins configurations
packer.startup(function(use)
	-- Let packer manage itself
	use { 'wbthomason/packer.nvim' }

	-- increase startup speed
	use { "lewis6991/impatient.nvim" }

	--colorscheme
	use { "catppuccin/nvim",
		as = "catppuccin",
		run = ":CatppuccinCompile",
		config = function()
			require('configs.colorscheme')
		end
	}

	-- treesitter
	use { 'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		requires = {
			{ 'nvim-treesitter/playground' },
			{ 'nvim-treesitter/nvim-treesitter-textobjects' },
			{ 'p00f/nvim-ts-rainbow' },
			{ 'RRethy/nvim-treesitter-endwise' }
		},
		config = function()
			require('configs.treesitter')
		end
	}

	use { 'nvim-tree/nvim-tree.lua',
		requires = {
			'nvim-tree/nvim-web-devicons',
		},
		tag = 'nightly',
		config = function()
			require('configs.nvim-tree')
		end
	}

	-- telescope
	use { 'nvim-telescope/telescope.nvim',
		requires = {
			'nvim-lua/plenary.nvim',
			{ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
			{ 'nvim-telescope/telescope-ui-select.nvim' },
		},
		config = function()
			require('configs.telescope')
		end
	}

	-- ThePrimeagen harpoon
	use { 'ThePrimeagen/harpoon',
		requires = 'nvim-lua/plenary.nvim',
	}

	-- navigate
	use { 'phaazon/hop.nvim',
		branch = 'v1', -- optional but strongly recommended
		config = function()
			require('configs.hop')
		end
	}

	-- git
	use { 'tpope/vim-fugitive' }
	use { 'lewis6991/gitsigns.nvim',
		requires = 'nvim-lua/plenary.nvim',
		config = function()
			require('configs.gitsigns')
		end
	}

	-- using packer.nvim
	use { 'akinsho/bufferline.nvim',
		tag = "v3.*",
		requires = 'nvim-tree/nvim-web-devicons',
		config = function()
			require('configs.bufferline')
		end
	}

	-- lualine & winbar
	use { 'nvim-lualine/lualine.nvim',
		requires = 'arkav/lualine-lsp-progress',
		config = function()
			require('configs.lualine')
		end
	}
	use { 'SmiteshP/nvim-navic', requires = 'neovim/nvim-lspconfig' }

	-- icons
	use { "ryanoasis/vim-devicons" }
	use { "kyazdani42/nvim-web-devicons" }

	-- Show indent line
	use { "lukas-reineke/indent-blankline.nvim",
		config = function()
			require('configs.indent-blankline')
		end
	}
	-- comment
	use { 'tpope/vim-commentary' }

	-- lsp
	use { 'junnplus/lsp-setup.nvim',
		requires = {
			'neovim/nvim-lspconfig',
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
		},
		config = function()
			require('configs.lsp')
		end
	}
	use { 'ray-x/lsp_signature.nvim' }
	use { "antoinemadec/FixCursorHold.nvim",
		config = function() vim.g.cursorhold_updatetime = 100 end
	}
	use { "jose-elias-alvarez/null-ls.nvim" } -- for formatters and linters
	use { "RRethy/vim-illuminate",
		config = function()
			require('configs.illuminate')
		end
	}

	-- highlight todos comments
	use {
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require('configs.todo-comments')
		end
	}

	-- debugger
	use { "rcarriga/nvim-dap-ui",
		requires = {
			"mfussenegger/nvim-dap",
			"ravenxrz/DAPInstall.nvim",
		},
		config = function()
			require('configs.dap-config')
		end
	}

	-- flutter
	use { "akinsho/flutter-tools.nvim",
		ft = { 'flutter', 'dart', 'yaml' },
		requires = {
			"nvim-lua/plenary.nvim",
			'Nash0x7E2/awesome-flutter-snippets',
			'hrsh7th/cmp-nvim-lsp',
			'dart-lang/dart-vim-plugin',
			'RobertBrunhage/flutter-riverpod-snippets',
			'eliasreis54/vim-bloc-plugin',
		},
		config = function()
			require('configs.flutter-tools')
		end
	}
	use { 'akinsho/pubspec-assist.nvim',
		requires = 'plenary.nvim',
		config = function()
			require('pubspec-assist').setup()
		end,
	}

	--rust
	use { 'simrat39/rust-tools.nvim',
		require = {
			'nvim-lua/plenary.nvim',
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require('configs.rust-tools')
		end
	}

	-- completion
	use { 'hrsh7th/nvim-cmp',
		requires = {
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'hrsh7th/cmp-buffer' },
			{ 'hrsh7th/cmp-path' },
			{ 'hrsh7th/cmp-cmdline' },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "hrsh7th/cmp-nvim-lsp-signature-help" },
			{ 'saadparwaiz1/cmp_luasnip' },
			{ 'dmitmel/cmp-cmdline-history' },
			-- { 'hrsh7th/cmp-copilot' },
			{ 'andersevenrud/cmp-tmux' },
			{ 'onsails/lspkind-nvim' },
		},
		config = function()
			require('configs.cmp')
		end
	}
	use { 'L3MON4D3/LuaSnip',
		requires = { 'rafamadriz/friendly-snippets' },
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end
	}

	use { "akinsho/toggleterm.nvim",
		tag = '*',
		config = function()
			require('configs.toggleterm')
		end
	}

	-- copilot
	use { 'github/copilot.vim',
		config = function()
			require('configs.copilot')
		end
	}

	-- other
	use 'mbbill/undotree'
	use 'mtdl9/vim-log-highlighting'
	use 'szw/vim-g'
	use 'tpope/vim-sleuth'
	-- use 'tpope/vim-sensible'
	use 'tpope/vim-surround'
	use 'tpope/vim-rsi'
	use 'tpope/vim-unimpaired'
	use 'tpope/vim-eunuch'
	use 'tpope/vim-dispatch'
	use 'romainl/vim-cool' -- Auto hide search highlight

	use { 'norcalli/nvim-colorizer.lua',
		config = function()
			require 'colorizer'.setup()
		end
	}

	use { 'windwp/nvim-autopairs',
		config = function()
			require('configs.autopairs')
		end
	}

	use 'ThePrimeagen/vim-be-good'

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)

if packer_bootstrap then
	print '=================================='
	print '    Plugins are being installed'
	print '    Wait until Packer completes,'
	print '       then restart nvim'
	print '=================================='
	return
end
