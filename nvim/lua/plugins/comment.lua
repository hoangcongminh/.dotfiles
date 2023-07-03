return {
  -- comment
  'tpope/vim-commentary',
  event = "VeryLazy",
  config = function()
    vim.keymap.set("n", "<leader>/", ":Commentary<CR>", { noremap = true, silent = true })
    vim.keymap.set("v", "<leader>/", ":Commentary<CR>", { noremap = true, silent = true })
  end,
}
