require 'hop'.setup(
  { keys = 'etovxqpdygfblzhckisuran' }
)
vim.keymap.set('n', 'fw', "<cmd>lua require'hop'.hint_words()<cr>", { silent = true })
vim.keymap.set('n', 'fl', "<cmd>lua require'hop'.hint_lines()<cr>", { silent = true })