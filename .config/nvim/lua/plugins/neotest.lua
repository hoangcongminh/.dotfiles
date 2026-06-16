return {
  'nvim-neotest/neotest',
  ft = { 'dart' },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/nvim-nio',
    'sidlatau/neotest-dart',
  },
  keys = {
    { '<leader>Tr', function() require('neotest').run.run() end,                                desc = 'Run nearest test' },
    { '<leader>Td', function() require('neotest').run.run({ strategy = 'dap' }) end,             desc = 'Debug nearest test' },
    { '<leader>Tf', function() require('neotest').run.run(vim.fn.expand('%')) end,              desc = 'Run file' },
    { '<leader>Tl', function() require('neotest').run.run_last() end,                           desc = 'Run last' },
    { '<leader>Tx', function() require('neotest').run.stop() end,                               desc = 'Stop test' },
    { '<leader>Ts', function() require('neotest').summary.toggle() end,                         desc = 'Toggle summary' },
    { '<leader>To', function() require('neotest').output.open({ enter = true, auto_close = true }) end, desc = 'Output (float)' },
    { '<leader>Tp', function() require('neotest').output_panel.toggle() end,                    desc = 'Output panel' },
    { '<leader>Tw', function() require('neotest').watch.toggle(vim.fn.expand('%')) end,         desc = 'Watch file' },
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require('neotest-dart') {
          command = vim.fn.executable('fvm') == 1 and 'fvm flutter' or 'flutter',
          use_lsp = true,
        },
      },
      output = { open_on_run = false },
      quickfix = { open = false },
    }
  end,
}
