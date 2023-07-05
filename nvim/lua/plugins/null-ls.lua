return {
  "jose-elias-alvarez/null-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "mason.nvim" },
  opts = function()
    local null_ls = require("null-ls")
    return {
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.dart_format,
        null_ls.builtins.formatting.prettier,
      },
    }
  end,
}
