local status_ok, notify = pcall(require, "notify")
if not status_ok then
	return
end

vim.notify = notify

notify.setup({
	background_colour = "#000000",
	render = "minimal",
	stages = "static",
})
