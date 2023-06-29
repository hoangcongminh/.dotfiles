local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
	return
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local custom_capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

local lsp = vim.lsp.buf
local handlers = vim.lsp.handlers
local diagnostic = vim.diagnostic

local function format_buffer(is_print_formated)
	if vim.lsp.buf.format then
		vim.lsp.buf.format({ async = true })
	elseif vim.lsp.buf.formatting then
		vim.lsp.buf.formatting({ async = true })
	end

	if not is_print_formated then
		print("Formated!")
	end
end

local setup = function()
	local signs = {
		{ name = "DiagnosticSignError", text = " " },
		{ name = "DiagnosticSignWarn",  text = " " },
		{ name = "DiagnosticSignHint",  text = " " },
		{ name = "DiagnosticSignInfo",  text = " " },
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

	keymap({ 'n', 'i' }, '<C-k>', lsp.signature_help, opts)
	keymap('n', '<space>wa', lsp.add_workspace_folder, opts)
	keymap('n', '<space>wr', lsp.remove_workspace_folder, opts)
	keymap('n', '<space>wl', lsp.list_workspace_folders, opts)
	keymap('n', '<space>D', lsp.type_definition, opts)
	keymap('n', '<space>lr', vim.lsp.codelens.run, opts)
	keymap('n', 'gr',
		function()
			lsp.references({ includeDeclaration = false })
		end, opts)
	keymap('n', '<space>fm', format_buffer, opts)
	keymap('n', "<space>ws", lsp.workspace_symbol, opts)
	keymap('n', "<space>ds", lsp.document_symbol, opts)
	keymap('n', '<space>wl', lsp.list_workspace_folders, opts)
	keymap('n', "<space>rn", lsp.rename, opts)
	keymap('n', '<space>aw', lsp.code_action, opts)
	keymap('v', '<space>ca', lsp.range_code_action, opts)
end

local on_attach = function(client, bufnr)
	-- Format command
	vim.api.nvim_buf_create_user_command(bufnr, 'Format', format_buffer, { desc = 'Format current buffer with LSP' })

	-- Format on save
	vim.api.nvim_create_autocmd('BufWritePre', {
		callback = function()
			format_buffer(false)
		end,
		group = vim.api.nvim_create_augroup('FormatOnSave', { clear = true }),
		pattern = { "*.lua", "*.ts", "*.js", "*.go", "*.rs", "*.c", "*.cpp" },
	})

	lsp_keymaps(bufnr)
end

return {
	setup = setup,
	on_attach = on_attach,
	capabilities = custom_capabilities
}
