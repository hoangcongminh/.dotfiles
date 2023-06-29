require("nvim-autopairs").setup({
  check_ts = true, -- treesitter integration
  disable_filetype = { "TelescopePrompt", "vim" },
  ts_config = {
    lua = { 'string' }, -- it will not add a pair on that treesitter node
    javascript = { 'template_string' },
    java = false,       -- don't check treesitter on java
  },
  fast_wrap = {
    map = "<M-e>",
    chars = { "{", "[", "(", '"', "'" },
    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
    offset = 0, -- Offset from pattern match
    end_key = "$",
    keys = "qwertyuiopzxcvbnmasdfghjkl",
    check_comma = true,
    highlight = "PmenuSel",
    highlight_grey = "LineNr",
  },
})

require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done({}))
