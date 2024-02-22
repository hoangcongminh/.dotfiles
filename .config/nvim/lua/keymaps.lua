vim.keymap.set('n', '<leader>pv', ':Explore<CR>')

vim.keymap.set('n', '<leader>r', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- run tmux-sessionizer
vim.keymap.set('n', '<C-f>', '<cmd>silent !tmux neww tmux-sessionizer<CR>')

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- quickfix
vim.keymap.set('n', '<leader>co', ':copen<CR>')
vim.keymap.set('n', '<leader>cc', ':ccl<CR>')
vim.keymap.set('n', '<leader>ci', ':cli<CR>')
vim.keymap.set('n', '<leader>k', ':cp<CR>')
vim.keymap.set('n', '<leader>j', ':cn<CR>')

vim.keymap.set('n', '<leader>lo', ':lopen<CR>')
vim.keymap.set('n', '<leader>lc', ':lcl<CR>')
vim.keymap.set('n', '<leader>ll', ':lli<CR>')

--buffers
vim.keymap.set('n', '<tab>', ':bnext<CR>')
vim.keymap.set('n', '<s-tab>', ':bprevious<CR>')

-- Enhance keymaps --
vim.keymap.set('n', 'Y', 'yg$')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', 'J', 'mzJ`z')

-- Press jk fast to exit insert mode
vim.keymap.set('i', 'jk', '<ESC>')

-- Stay in indent mode
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Move text up and down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Move text up and down
vim.keymap.set('x', '<A-j>', ":move '>+1<CR>gv-gv")
vim.keymap.set('x', '<A-k>', ":move '<-2<CR>gv-gv")

-- greatest remap ever
vim.keymap.set('x', '<leader>p', [["_dP]])
