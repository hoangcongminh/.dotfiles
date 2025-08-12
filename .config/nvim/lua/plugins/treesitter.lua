return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { 'BufReadPost', 'BufNewFile' },
  main = 'nvim-treesitter.configs', -- Sets main module to use for opts
  opts = {
    ensure_installed = {},
    auto_install = true,
    sync_install = false,
    indent = { enable = false, disable = { 'dart' } },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { 'markdown' },
    },
  },
}
