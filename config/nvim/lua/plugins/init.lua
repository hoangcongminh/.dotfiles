return {
	{ "nvim-lua/plenary.nvim" },

	{
		"rose-pine/neovim",
		lazy = false,
		as = "rose-pine",
		config = function()
			require('rose-pine').setup({
				variant = "moon",
				styles = {
					bold = true,
					italic = true,
					transparency = true,
				},
			})
			vim.cmd.colorscheme("rose-pine")
		end
	},

	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
	},

	-- icons
	{ "ryanoasis/vim-devicons" },
	{ "kyazdani42/nvim-web-devicons" },

	-- other
	{ "mtdl9/vim-log-highlighting",  event = "VeryLazy" },
	{ "tpope/vim-sleuth",            event = "VeryLazy" },
	{ "tpope/vim-surround",          event = "VeryLazy" },
	{ "tpope/vim-rsi",               event = "VeryLazy" },
	{ "tpope/vim-unimpaired",        event = "VeryLazy" },
	{ "tpope/vim-eunuch",            event = "VeryLazy" },
	{ "tpope/vim-dispatch",          event = "VeryLazy" },
}
