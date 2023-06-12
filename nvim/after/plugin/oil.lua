local status_ok, oil = pcall(require, "oil")
if not status_ok then
	return
end

oil.setup({
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

vim.keymap.set("n", "-", oil.open, { desc = "Open parent directory" })
