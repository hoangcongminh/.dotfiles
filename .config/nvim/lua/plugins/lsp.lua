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
        'tsserver',
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
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        completion = {
          completeopt = 'menu,menuone,noinsert,noselect',
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
