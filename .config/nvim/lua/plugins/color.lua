return {
  'ellisonleao/gruvbox.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('gruvbox').setup {
      transparent_mode = true,
    }

    vim.cmd.colorscheme 'gruvbox'

    -- vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
    -- vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'CursorLine', { underline = true, bg = 'none', fg = 'none' })

    vim.opt.statusline = table.concat({
      '%m%y ',
      '%{luaeval("require\'nvim-web-devicons\'.get_icon_color_by_filetype(vim.bo.filetype)")}',
      '%f',
      '%m',
      '%r',
      '%=',
      '%{v:lua.LspStatus()}',
      '|',
      '%{&fileencoding}',
      '|',
      '%{&fileformat}',
      '|',
      '%c:%l/%L',
    }, ' ')

    function LspStatus()
      local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
      local clients = vim.lsp.get_clients()

      if next(clients) == nil then
        return 'No LSP'
      end

      for _, client in ipairs(clients) do
        if vim.tbl_contains(client.config.filetypes or {}, buf_ft) then
          return client.name
        end
      end
      return 'No LSP'
    end
  end,
}
