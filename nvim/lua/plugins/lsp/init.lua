return {

  -- lsp
  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim', run = ":MasonUpdate" }
    },
    config = function()
      local handlers = require("plugins.lsp.handlers")
      handlers.setup()

      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "bashls",
          "cssls",
          "dockerls",
          "gopls",
          "grammarly",
          "html",
          "jsonls",
          "lua_ls",
          "pyright",
          "clangd",
          "rust_analyzer",
          "tsserver",
          "eslint",
          "yamlls",
        },
        handlers = {
          function(server_name)
            local lsp = require("lspconfig")
            lsp[server_name].setup({
              on_attach = handlers.on_attach,
              capabilities = handlers.capabilities,
              flags = {
                debounce_text_changes = 150,
              },
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { 'vim' }
                  }
                }
              }
            })
            lsp['sourcekit'].setup {
              on_attach = handlers.on_attach,
              capabilities = handlers.capabilities,
            }
          end,
        },
      })
    end
  },
}
