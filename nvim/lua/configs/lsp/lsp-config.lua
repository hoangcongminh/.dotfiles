require('lsp-setup').setup({
	on_attach = require("configs.lsp.handlers").on_attach,
	capabilities = require("configs.lsp.handlers").capabilities,
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
						-- Get the language server to recognize the `vim` global
						globals = { 'vim', 'use' },
					},
				},
			}
		},
		rust_analyzer = require('lsp-setup.rust-tools').setup({
			server = {
				settings = {
					['rust-analyzer'] = {
						cargo = {
							loadOutDirsFromCheck = true,
						},
						procMacro = {
							enable = true,
						},
					},
				},
			},
		})
	}
})
