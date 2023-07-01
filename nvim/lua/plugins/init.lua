return {

	{ 'nvim-lua/plenary.nvim',        lazy = true },

	{ "stevearc/dressing.nvim",       lazy = true, },

	-- icons
	{ "ryanoasis/vim-devicons",       lazy = true, },
	{ "kyazdani42/nvim-web-devicons", lazy = true, },

	{
		'L3MON4D3/LuaSnip',
		event = "VeryLazy",
		dependencies = { 'rafamadriz/friendly-snippets' },
	},

	-- other
	{ 'mtdl9/vim-log-highlighting', event = "VeryLazy" },
	{ 'tpope/vim-sleuth',           event = "VeryLazy" },
	{ 'tpope/vim-surround',         event = "VeryLazy" },
	{ 'tpope/vim-rsi',              event = "VeryLazy" },
	{ 'tpope/vim-unimpaired',       event = "VeryLazy" },
	{ 'tpope/vim-eunuch',           event = "VeryLazy" },
	{ 'tpope/vim-dispatch',         event = "VeryLazy" },

}
