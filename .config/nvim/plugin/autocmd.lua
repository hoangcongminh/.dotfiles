-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank {
      higroup = 'IncSearch',
      timeout = 40,
    }
  end,
  group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
  pattern = '*',
})

-- show cursor line only in active window
local cursorGrp = vim.api.nvim_create_augroup('CursorLine', { clear = true })
vim.api.nvim_create_autocmd({ 'InsertLeave', 'WinEnter' }, {
  pattern = '*',
  command = 'set cursorline',
  group = cursorGrp,
})
vim.api.nvim_create_autocmd({ 'InsertEnter', 'WinLeave' }, { pattern = '*', command = 'set nocursorline', group = cursorGrp })

-- Auto resize windows
vim.api.nvim_create_autocmd('VimResized', {
  pattern = '*',
  command = 'wincmd =',
})

vim.api.nvim_create_autocmd('ColorScheme', {
  group = vim.api.nvim_create_augroup('wezterm_colorscheme', { clear = true }),
  callback = function(args)
    local colorschemes = {
      ['tokyonight-day'] = 'Tokyo Night Day',
      ['tokyonight-storm'] = 'Tokyo Night Storm',
      ['catppuccin-frappe'] = 'Catppuccin Frappe',
      ['catppuccin-latte'] = 'Catppuccin Latte',
      ['catppuccin-macchiato'] = 'Catppuccin Macchiato',
      ['catppuccin-mocha'] = 'Catppuccin Mocha',
      ['gruvbox'] = 'GruvboxDark',
      -- add more color schemes here ...
    }
    local colorscheme = colorschemes[args.match]
    if not colorscheme then
      return
    end
    -- Write the colorscheme to a file
    local filename = vim.fn.expand '.dotfiles/wezterm/colorscheme.txt'
    assert(type(filename) == 'string')
    local file = io.open(filename, 'w')
    -- assert(file)
    file:write(colorscheme)
    file:close()
    vim.notify('Setting WezTerm color scheme to ' .. colorscheme, vim.log.levels.INFO)
  end,
})

-- Unset relativenumber in insert mode
vim.api.nvim_create_autocmd('InsertEnter', { pattern = '*', command = 'set norelativenumber' })
vim.api.nvim_create_autocmd('InsertLeave', { pattern = '*', command = 'set relativenumber' })

-- Unset paste mode when leaving insert mode
vim.api.nvim_create_autocmd('InsertLeave', { pattern = '*', command = 'set nopaste' })
