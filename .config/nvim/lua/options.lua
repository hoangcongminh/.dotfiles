vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.shortmess:append 'c'

local options = {
  guicursor = '',
  cursorline = true,

  number = true,
  relativenumber = true,

  clipboard = 'unnamedplus',

  tabstop = 4,
  softtabstop = 4,
  shiftwidth = 4,
  shiftround = true,
  expandtab = true,

  smartindent = true,
  autoindent = true,
  breakindent = true,

  scrolloff = 8,
  sidescrolloff = 8,

  wrap = false,

  ignorecase = true,
  smartcase = true,
  hlsearch = false,
  incsearch = true,

  termguicolors = true,
  signcolumn = 'yes',
  colorcolumn = '80',
  cmdheight = 0,
  laststatus = 3,

  swapfile = false,
  backup = false,
  undodir = os.getenv 'HOME' .. '/.vim/undodir',
  undofile = true,

  updatetime = 50,
  mouse = 'a',
  -- winbar = '%m%y ' .. "%{%v:lua.require'nvim-web-devicons'.get_icon_color_by_filetype(&filetype)%} " .. '%f',

  statusline = ''
    -- .. '%#Substitute# %Y %0*' -- filetype
    .. '%m%y ' -- filetype
    .. "%{%v:lua.require'nvim-web-devicons'.get_icon_color_by_filetype(&filetype)%} " -- icon
    .. '%f' -- path
    .. '%m' -- modifed
    .. '%r' -- readonly
    .. '%=' -- separator
    .. ' %{&fileencoding} ' -- file encoding
    .. '|' -- padding
    .. ' %{&fileformat} ' -- file format
    .. '|' -- padding
    .. ' %c:%l/%L ', -- column at line per total lines
}

for option, value in pairs(options) do
  vim.opt[option] = value
end
