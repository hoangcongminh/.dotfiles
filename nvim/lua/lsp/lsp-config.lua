local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
	return
end

local status_ok, mason = pcall(require, "mason")
if not status_ok then
	return
end

local lsp_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not lsp_status_ok then
	return
end

local handlers = require("lsp.handlers")

mason.setup()
mason_lspconfig.setup({
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
			lspconfig[server_name].setup({
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
