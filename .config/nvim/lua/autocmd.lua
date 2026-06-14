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
local resizeGrp = vim.api.nvim_create_augroup('AutoResize', { clear = true })
vim.api.nvim_create_autocmd('VimResized', {
  pattern = '*',
  command = 'wincmd =',
  group = resizeGrp,
})

-- Unset relativenumber in insert mode
local relnumGrp = vim.api.nvim_create_augroup('RelNumberInsert', { clear = true })
vim.api.nvim_create_autocmd('InsertEnter', { pattern = '*', command = 'set norelativenumber', group = relnumGrp })
vim.api.nvim_create_autocmd('InsertLeave', { pattern = '*', command = 'set relativenumber', group = relnumGrp })

-- Trim trailing whitespace on save
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  command = [[%s/\s\+$//e]],
  group = vim.api.nvim_create_augroup('TrimTrailingWhitespace', { clear = true }),
})
