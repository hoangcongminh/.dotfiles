vim.cmd.colorscheme 'gruvbox'

vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
-- vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'none' })
vim.api.nvim_set_hl(0, 'CursorLine', { underline = true, bg = 'none', fg = 'none' })

-- vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = 'none' })

-- winbar = '%m%y ' .. "%{%v:lua.require'nvim-web-devicons'.get_icon_color_by_filetype(&filetype)%} " .. '%f',

vim.opt.statusline = ''
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
  .. ' %c:%l/%L ' -- column at line per total lines
