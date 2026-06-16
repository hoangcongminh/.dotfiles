return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      { 'mason-org/mason-lspconfig.nvim' },
      { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
      { 'j-hui/fidget.nvim', opts = {} },
      { 'saghen/blink.cmp' },
    },
    config = function()
      -- LspAttach
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          local opts = { buffer = event.buf }

          vim.keymap.set('n', '[d', function()
            vim.diagnostic.jump { count = -1, float = true }
          end, opts)
          vim.keymap.set('n', ']d', function()
            vim.diagnostic.jump { count = 1, float = true }
          end, opts)
          vim.keymap.set('n', '<space>vd', vim.diagnostic.open_float, opts)
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

          vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)
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

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end

          -- Nvim 0.12+ auto-enables vim.lsp.document_color for any client with colorProvider.
          -- dartls advertises colorProvider in Flutter projects, then races analysis warmup,
          -- producing -32007 "File is not being analyzed" popups from flutter-tools' handler.
          if client and client.name == 'dartls' and vim.lsp.document_color then
            pcall(vim.lsp.document_color.enable, false, { client_id = client.id })
          end
        end,
      })

      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }

      local servers = {
        bashls = {},
        cssls = {},
        dockerls = {},
        gopls = {},
        html = {},
        jsonls = {},
        pyright = {},
        clangd = {},
        rust_analyzer = {},
        ts_ls = {},
        eslint = {},
        yamlls = {},
        lemminx = {},
        kotlin_language_server = {},
        lua_ls = {
          settings = {
            Lua = {
              completion = { callSnippet = 'Replace' },
              diagnostics = {
                globals = { 'bit', 'vim', 'it', 'describe', 'before_each', 'after_each' },
              },
            },
          },
        },
        -- dartls intentionally omitted — flutter-tools.nvim registers it
      }

      vim.lsp.config('*', {
        capabilities = require('blink.cmp').get_lsp_capabilities(),
      })

      for name, cfg in pairs(servers) do
        vim.lsp.config(name, cfg)
      end

      local server_names = vim.tbl_keys(servers)
      local ensure_installed = vim.list_extend(vim.deepcopy(server_names), { 'stylua', 'prettier' })
      require('mason-tool-installer').setup {
        ensure_installed = ensure_installed,
        run_on_start = false,
      }

      vim.lsp.enable(server_names)
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    opts = {
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescript = { 'prettier' },
        typescriptreact = { 'prettier' },
        go = { 'goimports', 'gofmt', 'golines' },
        json = { 'prettier' },
        jsonc = { 'prettier' },
        yaml = { 'prettier' },
        html = { 'prettier' },
        css = { 'prettier' },
        markdown = { 'prettier' },
      },
    },
  },

  { -- Completion
    'saghen/blink.cmp',
    event = 'InsertEnter',
    version = '1.*',
    dependencies = { 'L3MON4D3/LuaSnip' },
    opts = {
      keymap = {
        preset = 'enter',
      },
      snippets = { preset = 'luasnip' },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
    },
  },
}
