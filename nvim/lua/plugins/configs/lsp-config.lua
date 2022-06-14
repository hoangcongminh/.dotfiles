local lsp_mapping = require 'plugins.configs.lsp-keymaps'.map

-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

require('nvim-lsp-setup').setup({
	on_attach = lsp_mapping,
	capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
	servers = {
		bashls = {},
		diagnosticls = {},
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
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})
