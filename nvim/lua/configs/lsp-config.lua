local lsp_mapping = require 'configs.lsp-keymaps'.map

require('nvim-lsp-setup').setup({
	on_attach = lsp_mapping,
	capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
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

vim.diagnostic.config({
	virtual_text = true,
	signs = false,
	underline = true,
	update_in_insert = true,
	severity_sort = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "single",
		source = "always",
		header = "",
		prefix = "",
	},
})
