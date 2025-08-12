return {
  'phaazon/hop.nvim',
  cmd = { 'HopWord', 'HopLine' },
  branch = 'v2',
  keys = {
    {
      'fw',
      function()
        require('hop').hint_words()
      end,
      desc = 'Hop to word',
    },
    {
      'fl',
      function()
        require('hop').hint_lines()
      end,
      desc = 'Hop to line',
    },
  },
  config = function()
    local hop = require 'hop'
    hop.setup { keys = 'etovxqpdygfblzhckisuran' }
  end,
}
