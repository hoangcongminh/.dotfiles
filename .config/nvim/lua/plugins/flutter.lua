return {
  {
    'akinsho/flutter-tools.nvim',
    ft = { 'dart', 'yaml' },
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      'Nash0x7E2/awesome-flutter-snippets',
      'RobertBrunhage/flutter-riverpod-snippets',
    },
    config = function()
      require 'custom.flutter'
    end,
  },

  -- {
  --   'akinsho/pubspec-assist.nvim',
  --   ft = { 'dart', 'yaml' },
  --   event = 'BufEnter pubspec.yaml',
  --   config = function()
  --     require('pubspec-assist').setup()
  --   end,
  -- },
}
