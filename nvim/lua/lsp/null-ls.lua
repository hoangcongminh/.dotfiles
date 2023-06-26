local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local builtins = null_ls.builtins
local formatting = builtins.formatting
local diagnostics = builtins.diagnostics
local completion = builtins.completion
local code_actions = builtins.code_actions

null_ls.setup({
	sources = {
		formatting.dart_format,
		formatting.prettier,
		-- formatting.eslint,
		-- formatting.stylua,
		formatting.google_java_format,
		-- diagnostics.eslint,
		completion.spell,
		-- code_actions.eslint,
	},
})
