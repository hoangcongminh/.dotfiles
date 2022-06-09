local function map(_, bufnr)

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
  keymap('n', '<space>ca', vim.lsp.buf.code_action, opts)
  keymap('v', '<space>ca', vim.lsp.buf.range_code_action, opts)
  keymap('n', "<space>fm", vim.lsp.buf.formatting, opts)
  keymap('n', '<space>aw', ':CodeActionMenu<CR>', opts)
end

return { map = map }
