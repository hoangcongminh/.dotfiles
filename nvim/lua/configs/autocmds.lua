-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank({
			higroup = 'IncSearch',
			timeout = 40,
		})
	end,
	group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
	pattern = '*',
})

-- show cursor line only in active window
local cursorGrp = vim.api.nvim_create_augroup("CursorLine", { clear = true })
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
	pattern = "*",
	command = "set cursorline",
	group = cursorGrp,
})
vim.api.nvim_create_autocmd(
	{ "InsertEnter", "WinLeave" },
	{ pattern = "*", command = "set nocursorline", group = cursorGrp }
)

-- Unset relativenumber in insert mode
vim.api.nvim_create_autocmd(
	"InsertEnter",
	{ pattern = "*", command = "set norelativenumber" }
)
vim.api.nvim_create_autocmd(
	"InsertLeave",
	{ pattern = "*", command = "set relativenumber" }
)
-- Unset paste mode when leaving insert mode
vim.api.nvim_create_autocmd(
	"InsertLeave",
	{ pattern = "*", command = "set nopaste" }
)
