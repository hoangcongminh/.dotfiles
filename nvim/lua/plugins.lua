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
	{ "ellisonleao/gruvbox.nvim" },

	-- treesitter
	{
		'nvim-treesitter/nvim-treesitter',
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
	{ 'stevearc/oil.nvim' },

	-- ThePrimeagen harpoon
	{ 'ThePrimeagen/harpoon',        dependencies = 'nvim-lua/plenary.nvim' },

	-- navigate
	{ 'phaazon/hop.nvim',            branch = 'v1' },

	-- git
	{ 'tpope/vim-fugitive',          dependencies = 'tpope/vim-rhubarb' },
	{ 'lewis6991/gitsigns.nvim',     dependencies = 'nvim-lua/plenary.nvim' },

	-- lualine & winbar
	{ 'nvim-lualine/lualine.nvim',   dependencies = 'arkav/lualine-lsp-progress' },

	-- icons
	{ "ryanoasis/vim-devicons" },
	{ "kyazdani42/nvim-web-devicons" },

	-- comment
	{ 'tpope/vim-commentary' },

	-- lsp
	{
		'junnplus/lsp-setup.nvim',
		dependencies = {
			'neovim/nvim-lspconfig',
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
		},
	},
	{ 'ray-x/lsp_signature.nvim' },
	{ "jose-elias-alvarez/null-ls.nvim" }, -- for formatters and linters,

	-- highlight todos comments
	{ "folke/todo-comments.nvim",       dependencies = "nvim-lua/plenary.nvim" },

	-- debugger
	-- { "rcarriga/nvim-dap-ui",
	-- 	dependencies = {
	-- 		"mfussenegger/nvim-dap",
	-- 		"ravenxrz/DAPInstall.nvim",
	-- 	}
	-- },

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
		dependencies = { 'rafamadriz/friendly-snippets' },
	},

	-- terminal
	{ "akinsho/toggleterm.nvim" },

	-- copilot
	{ 'github/copilot.vim' },

	-- markdown
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		config = function() vim.g.mkdp_filetypes = { "markdown" } end,
		ft = { "markdown" },
	},

	-- other
	{ 'mbbill/undotree' },
	{ 'mtdl9/vim-log-highlighting' },
	{ 'tpope/vim-sleuth' },
	{ 'tpope/vim-surround' },
	{ 'tpope/vim-rsi' },
	{ 'tpope/vim-unimpaired' },
	{ 'tpope/vim-eunuch' },
	{ 'tpope/vim-dispatch' },
	{ 'norcalli/nvim-colorizer.lua' },
	{ 'windwp/nvim-autopairs' },
}

local opts = {
	ui = {
		border = "single",
	}
}

require("lazy").setup(plugins, opts)
