return {
  'phaazon/hop.nvim',
  event = 'VeryLazy',
  branch = 'v2',
  config = function()
    local hop = require 'hop'
    hop.setup {
      keys = 'etovxqpdygfblzhckisuran',
    }

    vim.keymap.set('n', 'fw', function()
      hop.hint_words()
    end)
    vim.keymap.set('n', 'fl', function()
      hop.hint_lines()
    end)
  end,
}
