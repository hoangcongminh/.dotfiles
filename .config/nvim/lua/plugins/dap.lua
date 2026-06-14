return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      { 'rcarriga/nvim-dap-ui', dependencies = { 'nvim-neotest/nvim-nio' } },
      'theHamsta/nvim-dap-virtual-text',
    },
    keys = {
      { '<leader>Db', function() require('dap').toggle_breakpoint() end,                                              desc = 'Toggle breakpoint' },
      { '<leader>DB', function() require('dap').set_breakpoint(vim.fn.input('Condition: ')) end,                      desc = 'Conditional breakpoint' },
      { '<leader>DL', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log message: ')) end,          desc = 'Logpoint' },
      { '<leader>Dc', function() require('dap').continue() end,                                                       desc = 'Continue / start' },
      { '<leader>Di', function() require('dap').step_into() end,                                                      desc = 'Step into' },
      { '<leader>Do', function() require('dap').step_over() end,                                                      desc = 'Step over' },
      { '<leader>DO', function() require('dap').step_out() end,                                                       desc = 'Step out' },
      { '<leader>Dr', function() require('dap').repl.toggle() end,                                                    desc = 'Toggle REPL' },
      { '<leader>Dl', function() require('dap').run_last() end,                                                       desc = 'Run last' },
      { '<leader>Dt', function() require('dap').terminate() end,                                                      desc = 'Terminate' },
      { '<leader>Du', function() require('dapui').toggle() end,                                                       desc = 'Toggle dap-ui' },
      { '<leader>De', function() require('dapui').eval() end, mode = { 'n', 'v' },                                    desc = 'Eval expression' },
    },
    config = function()
      local dap, dapui = require('dap'), require('dapui')

      dapui.setup()
      require('nvim-dap-virtual-text').setup {}

      dap.listeners.before.attach.dapui_config = function() dapui.open() end
      dap.listeners.before.launch.dapui_config = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
      dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

      vim.fn.sign_define('DapBreakpoint',          { text = '●', texthl = 'DiagnosticError', linehl = '', numhl = '' })
      vim.fn.sign_define('DapBreakpointCondition', { text = '◆', texthl = 'DiagnosticWarn',  linehl = '', numhl = '' })
      vim.fn.sign_define('DapLogPoint',            { text = '◆', texthl = 'DiagnosticInfo',  linehl = '', numhl = '' })
      vim.fn.sign_define('DapStopped',             { text = '▶', texthl = 'DiagnosticOk',    linehl = 'Visual', numhl = '' })
      vim.fn.sign_define('DapBreakpointRejected',  { text = '○', texthl = 'DiagnosticHint',  linehl = '', numhl = '' })
    end,
  },
}
