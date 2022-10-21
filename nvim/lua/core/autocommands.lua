-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

-- Unset relativenumber in insert mode
vim.cmd("au InsertEnter * set norelativenumber")
vim.cmd("au InsertLeave * set relativenumber")

-- Unset paste mode when leaving insert mode
vim.cmd("au InsertLeave * set nopaste")
