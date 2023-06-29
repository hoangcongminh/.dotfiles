require("oil").setup({
	columns = {
		"icon",
		-- "permissions",
		-- "size",
		-- "mtime",
	},
	view_options = {
		show_hidden = true,
	},
})

vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
