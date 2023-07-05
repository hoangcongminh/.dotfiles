return {
  -- copilot
  "github/copilot.vim",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    -- vim.keymap.set("i", "<C-k>", "copilot#Accept()", { silent = true, script = true, expr = true })
    -- vim.g.copilot_no_tab_map = true
    -- vim.g.copilot_assume_mapped = true
  end,
}
