if vim.loader then vim.loader.enable() end

require('configs.options')
require("configs.autocmds")
require('configs.keymaps')
require('configs.plugins')
