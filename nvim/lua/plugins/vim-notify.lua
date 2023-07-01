return {

	{
		'rcarriga/nvim-notify',
		config = function()
			vim.notify = require("notify")

			require("notify").setup({
				top_down = false,
				background_colour = 'NormalFloat',
				render = "minimal",
				stages = "static",
				max_width = function() return math.floor(vim.o.columns * 0.6) end,
				max_height = function() return math.floor(vim.o.lines * 0.8) end,
			})
		end
	},
}
