local function map(_, bufnr)

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }
  local keymap = vim.keymap.set

  keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  keymap('n', '<space>la', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  keymap('n', '<space>qa', '<cmd>lua vim.diagnostic.setqflist({title="warnings",severity=vim.diagnostic.severity.WARN})<CR>', opts)
  keymap('n', '<space>qe', '<cmd>lua vim.diagnostic.setqflist({severity=vim.diagnostic.severity.ERROR})<CR> <cmd>silent cr<CR>', opts)
  keymap('n', '<space>a', '<cmd>lua vim.diagnostic.setqflist()<CR>', opts)

  keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  -- keymap('n', '<space>aw', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- keymap('x', '<space>aw', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
  keymap('n', '<space>aw', ':CodeActionMenu<CR>', opts)
  keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references({includeDeclaration=false})<CR>', opts)
  keymap('n', "<space>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  keymap('n', "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  keymap('n', "<space>ws", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", opts)
  keymap('n', "<space>ds", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", opts)
  keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
end

return { map = map }
