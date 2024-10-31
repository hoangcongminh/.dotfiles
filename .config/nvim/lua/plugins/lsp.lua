return {
  { -- lsp
    'neovim/nvim-lspconfig',
    event = 'VeryLazy',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = 'LuaJIT' },
              workspace = {
                checkThirdParty = false,
                library = {
                  '${3rd}/luv/library',
                  unpack(vim.api.nvim_get_runtime_file('', true)),
                },
              },
              completion = {
                callSnippet = 'Replace',
              },
              diagnostics = { disable = { 'missing-fields', 'redundant-parameter' } },
            },
          },
        },
      }

      require('mason').setup()

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua',
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
        'ts_ls',
        'eslint',
        'yamlls',
        'lemminx',
        'kotlin_language_server',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }
      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)

            require('lspconfig')['sourcekit'].setup {
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

      -- LspAttach
      vim.api.nvim_create_autocmd('LspAttach', {
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
      require 'custom.completion'
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
