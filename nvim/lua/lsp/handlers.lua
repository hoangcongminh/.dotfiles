local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
	return
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

local lsp = vim.lsp.buf
local handlers = vim.lsp.handlers
local diagnostic = vim.diagnostic

M.setup = function()
	local signs = {
		-- { name = "DiagnosticSignError", text = "" },
		-- { name = "DiagnosticSignWarn", text = "" },
		-- { name = "DiagnosticSignHint", text = "" },
		-- { name = "DiagnosticSignInfo", text = "" },
		{ name = "DiagnosticSignError", text = "E" },
		{ name = "DiagnosticSignWarn",  text = "W" },
		{ name = "DiagnosticSignHint",  text = "H" },
		{ name = "DiagnosticSignInfo",  text = "I" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		virtual_text = true,
		signs = {
			active = signs,
		},
		underline = true,
		update_in_insert = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "single",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	diagnostic.config(config)

	handlers["textDocument/hover"] = vim.lsp.with(
		handlers.hover, {
			border = "single",
		})

	handlers["textDocument/signatureHelp"] = vim.lsp.with(
		handlers.signature_help, {
			border = "single",
		})
end

local function lsp_keymaps(bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Format command
	vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
		if vim.lsp.buf.format then
			vim.lsp.buf.format({ async = true })
		elseif vim.lsp.buf.formatting then
			vim.lsp.buf.formatting({ async = true })
		end
	end, { desc = 'Format current buffer with LSP' })

	local opts = { noremap = true, silent = true, buffer = bufnr }
	local keymap = vim.keymap.set

	keymap('n', '<space>e', diagnostic.open_float, opts)
	keymap('n', '[d', diagnostic.goto_prev, opts)
	keymap('n', ']d', diagnostic.goto_next, opts)
	keymap('n', '<space>la', diagnostic.setloclist, opts)
	keymap('n', '<space>qa', function()
		diagnostic.setqflist({
			title = "warnings",
			severity = vim.diagnostic.severity.WARN
		})
	end, opts)
	keymap('n', '<space>qe', function()
		diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })
	end, opts)
	keymap('n', '<space>a', diagnostic.setqflist, opts)
	keymap('n', 'gD', lsp.declaration, opts)
	keymap('n', 'gd', lsp.definition, opts)
	keymap('n', 'gi', lsp.implementation, opts)
	keymap('n', 'K', lsp.hover, opts)

	keymap('n', '<C-k>', lsp.signature_help, opts)
	keymap('n', '<space>wa', lsp.add_workspace_folder, opts)
	keymap('n', '<space>wr', lsp.remove_workspace_folder, opts)
	keymap('n', '<space>wl', lsp.list_workspace_folders, opts)
	keymap('n', '<space>D', lsp.type_definition, opts)
	keymap('n', '<space>lr', vim.lsp.codelens.run, opts)
	keymap('n', 'gr',
		function()
			lsp.references({ includeDeclaration = false })
		end, opts)
	keymap('n', '<space>fm', vim.cmd.Format, opts)
	keymap('n', "<space>ws", lsp.workspace_symbol, opts)
	keymap('n', "<space>ds", lsp.document_symbol, opts)
	keymap('n', '<space>wl', lsp.list_workspace_folders, opts)
	keymap('n', "<space>rn", lsp.rename, opts)
	keymap('n', '<space>aw', lsp.code_action, opts)
	keymap('v', '<space>ca', lsp.range_code_action, opts)
end

M.on_attach = function(client, bufnr)
	if client.name == "tsserver" then
		client.server_capabilities.document_formatting = false
	end

	if client.name == "sumneko_lua" then
		client.server_capabilities.document_formatting = false
	end

	lsp_keymaps(bufnr)

	local ok, lsp_format = pcall(require, "lsp-format")
	if ok then
		lsp_format.on_attach(client)
	end

	-- Fotmat on save
	-- vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()]]
	-- require('lsp-setup.utils').format_on_save(client)
end

return M
