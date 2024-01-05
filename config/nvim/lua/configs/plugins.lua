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

require("lazy").setup("plugins", {
	defaults = {
		lazy = true,
		version = false,
	},
	change_detection = { notify = false },
	checker = {
		enabled = false,
		-- concurrency = 30,
		-- notify = false,
		-- frequency = 3600, -- check for updates every hour
	},
	performance = {
		cache = {
			enabled = true,
			-- disable_events = {},
		},
		rtp = {
			paths = { vim.fn.stdpath("data") .. "/site" },
			disabled_plugins = {
				-- "netrw",
				-- "netrwPlugin",
				"gzip",
				-- "matchit",
				-- "matchparen",
				-- "netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})

vim.keymap.set("n", "<leader>pl", "<cmd>Lazy <CR>", { noremap = true, silent = true })
