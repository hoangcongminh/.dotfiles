function _G.LspStatus()
  local buf_ft = vim.bo[0].filetype
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
