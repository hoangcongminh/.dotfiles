local handlers = require("lsp.handlers")

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"bashls",
		"cssls",
		"dockerls",
		"gopls",
		"grammarly",
		"html",
		"jsonls",
		"lua_ls",
		"pyright",
		"clangd",
		"rust_analyzer",
		"tsserver",
		"eslint",
		"yamlls",
	},
	handlers = {
		function(server_name)
			require("lspconfig")[server_name].setup({
				on_attach = handlers.on_attach,
				capabilities = handlers.capabilities,
				flags = {
					debounce_text_changes = 150,
				},
				settings = {
					Lua = {
						diagnostics = {
							globals = { 'vim' }
						}
					}
				}
			})
		end,
	},
})
