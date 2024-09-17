-- netwr options
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.netrw_bufsettings = 'noma nomod nu nowrap ro nobl'

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

  smartcase = true,
  ignorecase = true,
  hlsearch = false,
  incsearch = true,

  termguicolors = true,
  signcolumn = 'yes',
  -- colorcolumn = '80',
  cmdheight = 0,
  laststatus = 3,

  swapfile = false,
  backup = false,
  undodir = os.getenv 'HOME' .. '/.vim/undodir',
  undofile = true,

  updatetime = 50,
  mouse = 'a',
}

for option, value in pairs(options) do
  vim.opt[option] = value
end
