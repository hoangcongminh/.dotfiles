return {
  'mbbill/undotree',
  cmd = {
    "UndotreeShow",
    "UndotreeToggle",
  },
  config = function()
    vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
  end
}
