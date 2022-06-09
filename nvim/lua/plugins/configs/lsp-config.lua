local lsp_mapping = require 'plugins.configs.lsp-keymaps'.map

require('nvim-lsp-setup').setup({
	on_attach = lsp_mapping,
	servers = {
		bashls = {},
		diagnosticls = {},
		pyright = {},
		yamlls = {},
		tsserver = {},
		jsonls = {},
		sumneko_lua = {
			settings = {
				Lua = {
					runtime = {
						-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
						version = 'LuaJIT',
						-- Setup your lua path
						path = runtime_path,
					},
					diagnostics = {
						-- Get the language server to recognize the `vim` global
						globals = { 'vim', 'use' },
					},
					workspace = {
						-- Make the server aware of Neovim runtime files
						library = vim.api.nvim_get_runtime_file('', true),
					},
					-- Do not send telemetry data containing a randomized but unique identifier
					telemetry = {
						enable = false,
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
