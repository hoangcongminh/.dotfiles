return {
    "VonHeikemen/lsp-zero.nvim",
    event = "VeryLazy",
    dependencies = {
        "neovim/nvim-lspconfig",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",

        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lua",
        "saadparwaiz1/cmp_luasnip",

        "L3MON4D3/LuaSnip",
        "rafamadriz/friendly-snippets",
    },
    config = function()
        local lsp_zero = require('lsp-zero')
        require("mason").setup({})
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
                "lemminx",
                "kotlin_language_server",
            },
            handlers = {
                lsp_zero.default_setup,
            },
        })

        lsp_zero.format_on_save({
            format_opts = {
                async = false,
                timeout_ms = 10000,
            },
            servers = {
                ['lua_ls'] = { 'lua' },
                ['gopls'] = { 'go' },
                ['dartls'] = { 'dart' },
                ['tsserver'] = { 'javascript', 'typescript' },
            }
        })

        local ls = require("luasnip")

        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_vscode").lazy_load({ paths = "./snippets" })
        ls.filetype_extend("dart", { "flutter" })


        local cmp = require("cmp")
        local cmp_action = require("lsp-zero").cmp_action()

        cmp.setup({
            preselect = 'item',
            completion = {
                completeopt = 'menu,menuone,noinsert'
            },
            sources = {
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "path" },
                { name = "nvim_lua" }
            },
            formatting = lsp_zero.cmp_format(),
            mapping = cmp.mapping.preset.insert({
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                ['<C-d>'] = cmp.mapping.scroll_docs(4),
            }),
        })

        cmp.setup.cmdline({ "/", "?" }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" },
            },
        })

        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "path" },
                { name = "cmdline" },
            }),
        })

        lsp_zero.on_attach(function(client, bufnr)
            local opts = { buffer = bufnr, remap = false }

            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
            vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
            vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
            vim.keymap.set({ "n", "x" }, "<leader>=", vim.lsp.buf.format, opts)
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
            vim.keymap.set("n", "<leader>a", vim.diagnostic.setqflist, opts)
            vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        end)
    end,
}
