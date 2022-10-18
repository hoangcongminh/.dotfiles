local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
	return
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.setup = function()
	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		virtual_text = true, -- disable virtual text
		signs = {
			active = signs, -- show signs
		},
		underline = true,
		update_in_insert = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

local function lsp_keymaps(bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	local opts = { noremap = true, silent = true, buffer = bufnr }
	local keymap = vim.keymap.set

	keymap('n', '<space>e', vim.diagnostic.open_float, opts)
	keymap('n', '[d', vim.diagnostic.goto_prev, opts)
	keymap('n', ']d', vim.diagnostic.goto_next, opts)
	keymap('n', '<space>la', vim.diagnostic.setloclist, opts)
	keymap('n', '<space>qa', function()
		vim.diagnostic.setqflist({ title = "warnings",
			severity = vim.diagnostic.severity.WARN })
	end, opts)
	keymap('n', '<space>qe', function()
		vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })
	end, opts)
	keymap('n', '<space>a', vim.diagnostic.setqflist, opts)
	keymap('n', 'gD', vim.lsp.buf.declaration, opts)
	keymap('n', 'gd', vim.lsp.buf.definition, opts)
	keymap('n', 'K', vim.lsp.buf.hover, opts)
	keymap('n', 'gi', vim.lsp.buf.implementation, opts)
	keymap('n', '<C-k>', vim.lsp.buf.signature_help, opts)
	keymap('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
	keymap('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
	keymap('n', '<space>wl', vim.lsp.buf.list_workspace_folders, opts)
	keymap('n', '<space>D', vim.lsp.buf.type_definition, opts)
	keymap('n', '<space>lr', vim.lsp.codelens.run, opts)
	keymap('n', 'gr', function()
		vim.lsp.buf.references({ includeDeclaration = false })
	end, opts)
	keymap('n', "<space>ws", vim.lsp.buf.workspace_symbol, opts)
	keymap('n', "<space>ds", vim.lsp.buf.document_symbol, opts)
	keymap('n', '<space>wl', vim.lsp.buf.list_workspace_folders, opts)
	keymap('n', "<space>rn", vim.lsp.buf.rename, opts)
	keymap('n', '<space>aw', vim.lsp.buf.code_action, opts)
	keymap('v', '<space>ca', vim.lsp.buf.range_code_action, opts)
	keymap('n', "<space>fm", vim.lsp.buf.formatting, opts)
end

M.on_attach = function(client, bufnr)
	if client.name == "tsserver" then
		client.server_capabilities.document_formatting = false
	end

	if client.name == "sumneko_lua" then
		client.server_capabilities.document_formatting = false
	end

	lsp_keymaps(bufnr)

	local illuminate_status_ok, illuminate = pcall(require, "illuminate")
	if not illuminate_status_ok then
		return
	end

	illuminate.on_attach(client)

	local navic_status_ok, navic = pcall(require, "nvim-navic")
	if not navic_status_ok then
		return
	end

	navic.attach(client, bufnr)

	-- Fotmat on save
	-- vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()]]
	require('lsp-setup.utils').format_on_save(client)
end

return M
