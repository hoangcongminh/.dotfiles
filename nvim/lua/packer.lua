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
	git = {
		clone_timeout = 600,
	},
	max_jobs = 10,
	luarocks = {
		python_cmd = 'python3'
	},
})

-- Plugins configurations
packer.startup(function(use)
	-- Let packer manage itself
	use { 'wbthomason/packer.nvim' }

	-- increase startup speed
	use { "lewis6991/impatient.nvim" }

	--colorscheme
	use({ 'rose-pine/neovim', as = 'rose-pine' })

	-- treesitter
	use { 'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		requires = {
			{ 'nvim-treesitter/playground' },
			{ 'nvim-treesitter/nvim-treesitter-textobjects' },
			{ 'p00f/nvim-ts-rainbow' },
			{ 'RRethy/nvim-treesitter-endwise' },
			{ 'nvim-treesitter/nvim-treesitter-context' }
		},
	}

	-- telescope
	use { 'nvim-telescope/telescope.nvim',
		requires = {
			'nvim-lua/plenary.nvim',
			{ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
			{ 'nvim-telescope/telescope-ui-select.nvim' },
		},
	}

	-- ThePrimeagen harpoon
	use { 'ThePrimeagen/harpoon', requires = 'nvim-lua/plenary.nvim' }

	-- navigate
	use { 'phaazon/hop.nvim', branch = 'v1' }

	-- git
	use { 'tpope/vim-fugitive', requires = 'tpope/vim-rhubarb' }
	use { 'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim' }

	-- lualine & winbar
	use { 'nvim-lualine/lualine.nvim', requires = 'arkav/lualine-lsp-progress' }
	use { 'SmiteshP/nvim-navic', requires = 'neovim/nvim-lspconfig' }
	use { 'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons' }


	-- icons
	use { "ryanoasis/vim-devicons" }
	use { "kyazdani42/nvim-web-devicons" }

	-- comment
	use { 'tpope/vim-commentary' }

	-- lsp
	use { 'junnplus/lsp-setup.nvim',
		requires = {
			'neovim/nvim-lspconfig',
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
		},
	}
	use { 'ray-x/lsp_signature.nvim' }
	use { "antoinemadec/FixCursorHold.nvim", config = function() vim.g.cursorhold_updatetime = 100 end }
	use { "jose-elias-alvarez/null-ls.nvim" } -- for formatters and linters

	-- highlight todos comments
	use { "folke/todo-comments.nvim", requires = "nvim-lua/plenary.nvim" }

	-- debugger
	-- use { "rcarriga/nvim-dap-ui",
	-- 	requires = {
	-- 		"mfussenegger/nvim-dap",
	-- 		"ravenxrz/DAPInstall.nvim",
	-- 	}
	-- }

	-- flutter
	use { "akinsho/flutter-tools.nvim",
		ft = { 'flutter', 'dart', 'yaml' },
		requires = {
			"nvim-lua/plenary.nvim",
			'Nash0x7E2/awesome-flutter-snippets',
			'hrsh7th/cmp-nvim-lsp',
			'dart-lang/dart-vim-plugin',
			'RobertBrunhage/flutter-riverpod-snippets',
			-- 'eliasreis54/vim-bloc-plugin',
			{
				'akinsho/pubspec-assist.nvim',
				requires = 'plenary.nvim',
				config = function()
					require('pubspec-assist').setup()
				end,
			}
		},
	}

	--rust
	-- use { 'simrat39/rust-tools.nvim',
	-- 	require = {
	-- 		'nvim-lua/plenary.nvim',
	-- 		"nvim-lua/plenary.nvim",
	-- 	},
	-- }

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
	}
	use { 'L3MON4D3/LuaSnip',
		requires = { 'rafamadriz/friendly-snippets' },
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end
	}

	-- terminal
	use { "akinsho/toggleterm.nvim", tag = '*' }

	-- copilot
	use { 'github/copilot.vim' }

	-- other
	use { 'mbbill/undotree' }
	use { 'mtdl9/vim-log-highlighting' }
	use { 'tpope/vim-sleuth' }
	use { 'tpope/vim-surround' }
	use { 'tpope/vim-rsi' }
	use { 'tpope/vim-unimpaired' }
	use { 'tpope/vim-eunuch' }
	use { 'tpope/vim-dispatch' }
	use { 'norcalli/nvim-colorizer.lua' }
	use { 'windwp/nvim-autopairs' }

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)
