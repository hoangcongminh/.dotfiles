function OnAttachLsp(_, bufnr)
  local opts = { buffer = bufnr }

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
  vim.keymap.set('n', '<space>lr', vim.vim.lsp.buf.codelens.run, opts)
  vim.keymap.set('n', 'gr', function()
    vim.lsp.buf.references { includeDeclaration = false }
  end, opts)
  vim.keymap.set('n', '<space>ws', vim.lsp.buf.workspace_symbol, opts)
  vim.keymap.set('n', '<space>ds', vim.lsp.buf.document_symbol, opts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<space>fm', function()
    require('conform').format()
  end, opts)

  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set('n', '<space>wl', vim.lsp.buf.list_workspace_folders, opts)
end

return {
  { -- lsp
    'neovim/nvim-lspconfig',
    event = { 'BufReadPost', 'BufNewFile' },
    cmd = { 'LspInfo', 'LspInstall', 'LspUninstall' },
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
    config = function()
      require('mason').setup()

      local capabilities = vim.tbl_deep_extend('force', {}, vim.lsp.protocol.make_client_capabilities(), require('cmp_nvim_lsp').default_capabilities())

      require('mason-lspconfig').setup {
        ensure_installed = {
          'bashls',
          'cssls',
          'dockerls',
          'gopls',
          'grammarly',
          'html',
          'jsonls',
          'lua_ls',
          'pyright',
          'clangd',
          'rust_analyzer',
          'tsserver',
          'eslint',
          'yamlls',
          'lemminx',
          'kotlin_language_server',
        },
        handlers = {
          function(server_name)
            require('lspconfig')[server_name].setup {
              on_attach = OnAttachLsp,
              capabilities = capabilities,
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { 'vim' },
                  },
                },
              },
            }
            require('lspconfig')['sourcekit'].setup {
              on_attach = OnAttachLsp,
              capabilities = capabilities,
            }
          end,
        },
      }

      vim.diagnostic.config {
        virtual_text = true,
        underline = true,
        update_in_insert = true,
        severity_sort = true,
        float = {
          focusable = false,
          style = 'minimal',
          border = 'rounded',
          source = 'always',
          header = '',
          prefix = '',
        },
      }
    end,
  },

  { -- completion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-cmdline' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'dmitmel/cmp-cmdline-history' },
    },
    config = function()
      local cmp = require 'cmp'

      cmp.setup {
        completion = {
          completeopt = 'menu,menuone,noinsert,noselect',
        },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = {
          ['<C-n>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
          ['<C-p>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
          ['<Down>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
          ['<Up>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          },
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
          { name = 'buffer' },
          { name = 'nvim_lua' },
          { name = 'buffer' },
        },
      }

      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' },
        },
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources {
          { name = 'path' },
          { name = 'cmdline' },
        },
      })
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    event = 'VeryLazy',
    opts = {
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { { 'prettierd', 'prettier' } },
      },
    },
  },
}
