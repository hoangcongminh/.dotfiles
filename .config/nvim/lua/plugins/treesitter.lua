return {
  -- treesitter
  'nvim-treesitter/nvim-treesitter',
  commit = '33eb472b459f1d2bf49e16154726743ab3ca1c6d',
  event = { 'BufReadPost', 'BufNewFile' },
  build = ':TSUpdate',
  dependencies = {
    { 'nvim-treesitter/nvim-treesitter-textobjects' },
    { 'p00f/nvim-ts-rainbow' },
  },
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = {
        'vimdoc',
        'vim',
        'lua',
        'http',
        'html',
        'json',
        'json5',
        'javascript',
        'typescript',
        'yaml',
        'bash',
        'dart',
        -- "rust",
        'toml',
        'go',
        'cpp',
        'c',
        'make',
        'swift',
        'kotlin',
      },
      highlight = {
        enable = true,
        disable = {},
        additional_vim_regex_highlighting = true,
      },
      autopairs = {
        enable = true,
      },
      indent = {
        enable = true,
        disable = { 'yaml' },
      },
      rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            [']m'] = '@function.outer',
            [']]'] = '@class.outer',
          },
          goto_next_end = {
            [']M'] = '@function.outer',
            [']['] = '@class.outer',
          },
          goto_previous_start = {
            ['[m'] = '@function.outer',
            ['[['] = '@class.outer',
          },
          goto_previous_end = {
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer',
          },
        },
      },
    }
  end,
}
