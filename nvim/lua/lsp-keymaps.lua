function map(_,bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  local opts = { noremap=true, silent=true }

  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  -- buf_set_keymap('n', '<space>la', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  -- buf_set_keymap('n', '<space>qa', '<cmd>lua vim.diagnostic.setqflist({title="warnings",severity=vim.diagnostic.severity.WARN})<CR>', opts)
  -- buf_set_keymap('n', '<space>qe', '<cmd>lua vim.diagnostic.setqflist({severity=vim.diagnostic.severity.ERROR})<CR> <cmd>silent cr<CR>', opts)
  -- buf_set_keymap('n', '<space>a', '<cmd>lua vim.diagnostic.setqflist()<CR>', opts)


  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'vlua.vim.lsp.omnifunc')

  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  -- buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references({includeDeclaration=false})<CR>', opts)
  buf_set_keymap('n', "<space>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  buf_set_keymap('n', "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap('n', "<space>ws", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", opts)
  buf_set_keymap('n', "<space>ds", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", opts)
  buf_set_keymap('n','<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',opts)
  buf_set_keymap('n','<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>',opts)
  -- lsp-fastaction
  buf_set_keymap('n', '<space>a', '<cmd>lua require("lsp-fastaction").code_action()<CR>', opts)
  buf_set_keymap('v', '<space>a', '<esc><cmd>lua require("lsp-fastaction").range_code_action()<CR>', opts)
end

return {map = map}
