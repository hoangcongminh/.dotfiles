require('nvim-treesitter').setup {
  ensure_install = { 'core', 'stable' },
  highlight = {
    enable = true,
    disable = {},
    additional_vim_regex_highlighting = true,
  },
  autopairs = {
    enable = true,
  },
}
