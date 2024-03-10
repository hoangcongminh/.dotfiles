require 'options'
require 'keymaps'
require 'plugin'

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.netrw_bufsettings = 'noma nomod nu nowrap ro nobl'

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank {
      higroup = 'IncSearch',
      timeout = 40,
    }
  end,
  group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
  pattern = '*',
})

-- show cursor line only in active window
local cursorGrp = vim.api.nvim_create_augroup('CursorLine', { clear = true })
vim.api.nvim_create_autocmd({ 'InsertLeave', 'WinEnter' }, {
  pattern = '*',
  command = 'set cursorline',
  group = cursorGrp,
})
vim.api.nvim_create_autocmd({ 'InsertEnter', 'WinLeave' }, { pattern = '*', command = 'set nocursorline', group = cursorGrp })

-- Unset relativenumber in insert mode
vim.api.nvim_create_autocmd('InsertEnter', { pattern = '*', command = 'set norelativenumber' })
vim.api.nvim_create_autocmd('InsertLeave', { pattern = '*', command = 'set relativenumber' })

-- Unset paste mode when leaving insert mode
vim.api.nvim_create_autocmd('InsertLeave', { pattern = '*', command = 'set nopaste' })

-- LspAttach
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(e)
    local opts = { buffer = e.buf }

    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '<space>la', vim.diagnostic.setloclist, opts)
    vim.keymap.set('n', '<space>a', vim.diagnostic.setqflist, opts)
    vim.keymap.set('n', '<space>qa', function()
      vim.diagnostic.setqflist {
        title = 'Warnings',
        severity = vim.diagnostic.severity.WARN,
      }
    end, opts)
    vim.keymap.set('n', '<space>qe', function()
      vim.diagnostic.setqflist {
        title = 'Errors',
        severity = vim.diagnostic.severity.ERROR,
      }
    end, opts)

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)

    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>ws', vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set('n', '<space>ds', vim.lsp.buf.document_symbol, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<space>fm', require('conform').format, opts)

    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', vim.lsp.buf.list_workspace_folders, opts)
  end,
})
