return {
	-- file manager
	"stevearc/oil.nvim",
	lazy = false,
	config = function()
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

		print("oil settings")
		vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
	end,
}
