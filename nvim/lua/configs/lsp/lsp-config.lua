require('lsp-setup').setup({
	on_attach = require("configs.lsp.handlers").on_attach,
	capabilities = require("configs.lsp.handlers").capabilities,
	servers = {
		bashls = {},
		pyright = {},
		yamlls = {},
		tsserver = {},
		eslint = {
			settings = {
				format = {
					enable = true,
				},
			}
		},
		jsonls = {},
		sumneko_lua = {
			settings = {
				Lua = {
					diagnostics = {
						-- Get the language server to recognize the `vim` global
						globals = { 'vim', 'use' },
					},
				},
			}
		},
	}
})
