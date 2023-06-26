local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	--colorscheme
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
	},

	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
	},

	-- treesitter
	{
		'nvim-treesitter/nvim-treesitter',
		event = { "BufReadPost", "BufNewFile" },
		commit = '33eb472b459f1d2bf49e16154726743ab3ca1c6d',
		build = ':TSUpdate',
		dependencies = {
			{ 'nvim-treesitter/playground' },
			{ 'nvim-treesitter/nvim-treesitter-textobjects' },
			{ 'p00f/nvim-ts-rainbow' },
			{ 'RRethy/nvim-treesitter-endwise' },
			{ 'nvim-treesitter/nvim-treesitter-context' }
		},
	},

	-- telescope
	{
		'nvim-telescope/telescope.nvim',
		cmd = "Telescope",
		dependencies = {
			{ 'nvim-lua/plenary.nvim' },
			{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
			{ 'nvim-telescope/telescope-ui-select.nvim' },
		},
	},

	-- file manager
	{
		'stevearc/oil.nvim',
		cmd = "Oil",
	},


	-- ThePrimeagen harpoon
	{
		'ThePrimeagen/harpoon',
		dependencies = 'nvim-lua/plenary.nvim',
	},

	-- motions
	{
		'phaazon/hop.nvim',
		event = "VeryLazy",
		branch = 'v1',
	},

	-- git
	{
		'tpope/vim-fugitive',
		dependencies = 'tpope/vim-rhubarb'
		,
	},
	{
		'lewis6991/gitsigns.nvim',
		event = "VeryLazy",
		dependencies = 'nvim-lua/plenary.nvim',
	},

	-- lualine & winbar
	{
		'nvim-lualine/lualine.nvim',
		event = "VeryLazy",
	},

	-- icons
	{
		"ryanoasis/vim-devicons",
		lazy = true,
	},
	{
		"kyazdani42/nvim-web-devicons",
		lazy = true,
	},

	-- comment
	{
		'tpope/vim-commentary',
		event = "VeryLazy",
	},

	-- lsp
	{
		"williamboman/mason-lspconfig.nvim",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			{ 'neovim/nvim-lspconfig' },
			{ 'williamboman/mason.nvim', run = ":MasonUpdate" }
		},
	},

	{
		'j-hui/fidget.nvim',
		event = "VeryLazy",
		tag = 'legacy',
	},

	-- highlight todos comments
	{
		"folke/todo-comments.nvim",
		dependencies = "nvim-lua/plenary.nvim",
	},

	-- debugger
	{
		"https://github.com/mfussenegger/nvim-dap",
		lazy = true,
	},

	{
		"https://github.com/rcarriga/nvim-dap-ui",
		lazy = true,
	},

	{
		"https://github.com/ravenxrz/DAPInstall.nvim",
		lazy = true,
	},

	-- flutter
	{
		"akinsho/flutter-tools.nvim",
		ft = { 'flutter', 'dart', 'yaml' },
		dependencies = {
			"nvim-lua/plenary.nvim",
			'stevearc/dressing.nvim', -- optional for vim.ui.select
			'Nash0x7E2/awesome-flutter-snippets',
			'hrsh7th/cmp-nvim-lsp',
			'dart-lang/dart-vim-plugin',
			'RobertBrunhage/flutter-riverpod-snippets',
			-- 'eliasreis54/vim-bloc-plugin',
			{
				'akinsho/pubspec-assist.nvim',
				dependencies = 'plenary.nvim',
			}
		},
	},

	--rust
	-- { 'simrat39/rust-tools.nvim',
	-- 	require = {
	-- 		'nvim-lua/plenary.nvim',
	-- 		"nvim-lua/plenary.nvim",
	-- 	},
	-- },

	-- completion
	{
		'hrsh7th/nvim-cmp',
		event = "VeryLazy",
		dependencies = {
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
	},
	{
		'L3MON4D3/LuaSnip',
		event = "VeryLazy",
		dependencies = { 'rafamadriz/friendly-snippets' },
	},

	-- terminal
	{ "akinsho/toggleterm.nvim" },

	-- copilot
	{
		'github/copilot.vim',
		event = { "BufReadPost", "BufNewFile" },
	},

	-- markdown
	{
		"iamcco/markdown-preview.nvim",
		ft = { "markdown" },
		build = "cd app && npm install",
	},

	-- other
	{
		'mbbill/undotree',
		cmd = {
			"UndotreeShow",
			"UndotreeToggle",
		}
	},
	{ 'mtdl9/vim-log-highlighting' },
	{ 'tpope/vim-sleuth' },
	{ 'tpope/vim-surround' },
	{ 'tpope/vim-rsi' },
	{ 'tpope/vim-unimpaired' },
	{ 'tpope/vim-eunuch' },
	{ 'tpope/vim-dispatch' },
	{ 'norcalli/nvim-colorizer.lua' },
	{
		'windwp/nvim-autopairs',
		event = { "BufReadPost", "BufNewFile" },
	},
}

local opts = {
	ui = {
		border = "single",
	}
}

require("lazy").setup(plugins, opts)
