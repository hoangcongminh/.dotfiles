require("toggleterm").setup({
  open_mapping = [[<c-\>]],
  shade_terminals = false,
})
local float_handler = function(term)
  if vim.fn.mapcheck('jk', 't') ~= '' then
    vim.api.nvim_buf_del_keymap(term.bufnr, 't', 'jk')
    vim.api.nvim_buf_del_keymap(term.bufnr, 't', '<esc>')
  end
end

local Terminal = require('toggleterm.terminal').Terminal

local lazygit = Terminal:new({
  cmd = 'lazygit',
  dir = 'git_dir',
  hidden = true,
  direction = 'float',
  on_open = float_handler,
})

local htop = Terminal:new({
  cmd = 'htop',
  hidden = true,
  direction = 'float',
  on_open = float_handler,
})

vim.api.nvim_create_user_command('Htop', function() htop:toggle() end, {})
vim.api.nvim_create_user_command('Lazygit', function() lazygit:toggle() end, {})

vim.keymap.set('n', '<leader>lg', function() lazygit:toggle() end, { noremap = true, silent = true })
