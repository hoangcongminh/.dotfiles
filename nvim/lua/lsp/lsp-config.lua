local lsp_status_ok, _ = pcall(require, "lspconfig")
if not lsp_status_ok then
	return
end

local status_ok, lsp_setup = pcall(require, "lsp-setup")
if not status_ok then
	return
end

local handlers = require("lsp.handlers")

lsp_setup.setup({
	on_attach = handlers.on_attach,
	capabilities = handlers.capabilities,
	servers = {
		bashls = {},
		pyright = {},
		yamlls = {},
		tsserver = {},
		gopls = {},
		eslint = {
			settings = {
				format = {
					enable = true,
				},
			}
		},
		jsonls = {},
		lua_ls = {
			settings = {
				Lua = {
					diagnostics = {
						globals = { 'vim', 'use' },
					},
				},
			}
		},
		-- rust_analyzer = require('lsp-setup.rust-tools').setup({
		-- 	server = {
		-- 		settings = {
		-- 			['rust-analyzer'] = {
		-- 				cargo = {
		-- 					loadOutDirsFromCheck = true,
		-- 				},
		-- 				procMacro = {
		-- 					enable = true,
		-- 				},
		-- 			},
		-- 		},
		-- 	},
		-- })
	}
})
