return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  lazy = false,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      transparent_background = true,
    })

    vim.cmd.colorscheme "catppuccin"

    -- vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
    -- vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'CursorLine', { underline = true, bg = 'none', fg = 'none' })

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
