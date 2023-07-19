return {
  -- completion
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-cmdline" },
    { "hrsh7th/cmp-nvim-lua" },
    { "hrsh7th/cmp-nvim-lsp-signature-help" },
    { "saadparwaiz1/cmp_luasnip" },
    { "dmitmel/cmp-cmdline-history" },
    -- { 'hrsh7th/cmp-copilot' },
    { "onsails/lspkind-nvim" },
  },
  config = function()
    -- Setup nvim-cmp.
    local cmp = require("cmp")

    local source_mapping = {
      nvim_lsp = "[LSP]",
      luasnip = "[LuaSnip]",
      path = "[Path]",
      buffer = "[Buffer]",
      nvim_lua = "[Lua]",
      -- copilot = "[Copilot]",
      cmdline = "[CMD]",
      cmdline_history = "[History]",
    }

    local winhighlight = {
      border = require("global").border,
      winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel",
    }

    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      window = {
        completion = cmp.config.window.bordered(winhighlight),
        documentation = cmp.config.window.bordered(winhighlight),
      },
      mapping = {
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping({
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        }),
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),
        -- ["<Tab>"] = cmp.mapping(function(fallback)
        --   if cmp.visible() then
        --     cmp.select_next_item()
        --   elseif luasnip.expand_or_jumpable() then
        --     luasnip.expand_or_jump()
        --   else
        --     fallback()
        --   end
        -- end, { "i", "s" }),

        -- ["<S-Tab>"] = cmp.mapping(function(fallback)
        --   if cmp.visible() then
        --     cmp.select_prev_item()
        --   elseif luasnip.jumpable(-1) then
        --     luasnip.jump(-1)
        --   else
        --     fallback()
        --   end
        -- end, { "i", "s" }),
      },
      formatting = {
        format = require("lspkind").cmp_format({
          mode = "symbol_text",
          maxwidth = 40,
          before = function(entry, vim_item)
            if vim.tbl_contains({ "path" }, entry.source.name) then
              local icon, hl_group =
                  require("nvim-web-devicons").get_icon(entry:get_completion_item().label)
              if icon then
                vim_item.kind = icon
                vim_item.kind_hl_group = hl_group
              end
            else
              vim_item.kind = require("lspkind").presets.default[vim_item.kind]
            end

            local menu = source_mapping[entry.source.name]
            vim_item.menu = menu

            return vim_item
          end,
        }),
        with_text = true,
      },
      confirmation = { completeopt = "menu,menuone,noinsert" },
      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" }, -- For luasnip users.
        { name = "path" },
        { name = "buffer" },
        { name = "nvim_lsp_signature_help" },
        { name = "nvim_lua" },
        -- { name = 'copilot' },
      },
      {
        { name = "buffer" },
      },
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
      }, {
        { name = "cmdline" },
        { name = "cmdline_history" },
      }),
    })
  end,
}
