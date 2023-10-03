return {
	"j-hui/fidget.nvim",
	event = "LspAttach",
	tag = "legacy",
	config = function()
		require("fidget").setup({
			text = {
				spinner = "meter",
			},
			timer = {
				spinner_rate = 125, -- frame rate of spinner animation, in ms
				fidget_decay = 1000, -- how long to keep around empty fidget, in ms
				task_decay = 500, -- how long to keep around completed task, in ms
			},
			window = {
				blend = 0,
			},
		})
	end,
}
