local nvim_lsp = require('lspconfig')
local lsp_mapping = require'lsp-keymaps'.map

local servers = {'tsserver','sumneko_lua'}
for _, lsp in ipairs(servers) do
   nvim_lsp[lsp].setup {
     on_attach = lsp_mapping,
     flags = {
       debounce_text_changes = 150,
     },
    settings = {
	  Lua = {
	      diagnostics = {
		  globals = { 'vim','use' }
	      }
	  }
      }
   }
 end
