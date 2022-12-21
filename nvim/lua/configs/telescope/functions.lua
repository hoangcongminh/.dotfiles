local M = {}
local telescope_builtin = require('telescope.builtin')

M.search_dotfiles = function()
  telescope_builtin.find_files({
    prompt_title = "~ .dotfiles ~",
    cwd = vim.env.DOTFILES,
    hidden = true,
    find_command = { 'rg', '--files', '--hidden', '-g', '!.git' },
  })
end

M.project_files = function()
  local opts = {
    find_command = { 'rg', '--files', '--hidden', '-g', '!.git' },
  }
  vim.fn.system('git rev-parse --is-inside-work-tree')
  if vim.v.shell_error == 0 then
    require "telescope.builtin".git_files(opts)
  else
    require "telescope.builtin".find_files(opts)
  end
end

return M
