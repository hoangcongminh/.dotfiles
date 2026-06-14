return {
  'folke/trouble.nvim',
  cmd = 'Trouble',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    focus = true,
    auto_close = true,
  },
  keys = {
    { '<leader>tt', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics (workspace)' },
    { '<leader>tb', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Diagnostics (buffer)' },
    { '<leader>tq', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix list' },
    { '<leader>tl', '<cmd>Trouble loclist toggle<cr>', desc = 'Location list' },
    { '<leader>tS', '<cmd>Trouble symbols toggle focus=false<cr>', desc = 'Symbols (LSP)' },
    { '<leader>tr', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', desc = 'LSP refs/defs/impl' },
  },
}
