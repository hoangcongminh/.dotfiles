local set = vim.keymap.set

set('n', '<leader>pv', ':Explore<CR>')

set('n', '<leader>r', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>')
set('n', '<C-d>', '<C-d>zz')
set('n', '<C-u>', '<C-u>zz')

-- run tmux-sessionizer
set('n', '<C-f>', '<cmd>silent !tmux neww tmux-sessionizer<CR>')

set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- quickfix
set('n', '<leader>co', ':copen<CR>')
set('n', '<leader>cc', ':ccl<CR>')
set('n', '<leader>ci', ':cli<CR>')
set('n', '<leader>k', ':cp<CR>')
set('n', '<leader>j', ':cn<CR>')

set('n', '<leader>lo', ':lopen<CR>')
set('n', '<leader>lc', ':lcl<CR>')
set('n', '<leader>ll', ':lli<CR>')

--buffers
set('n', '<tab>', ':bnext<CR>')
set('n', '<s-tab>', ':bprevious<CR>')

-- Enhance keymaps --
set('n', 'Y', 'yg$')
set('n', 'n', 'nzzzv')
set('n', 'N', 'Nzzzv')
set('n', 'J', 'mzJ`z')

-- Press jk fast to exit insert mode
set('i', 'jk', '<ESC>')

-- Stay in indent mode
set('v', '<', '<gv')
set('v', '>', '>gv')

-- Move text up and down
set('v', 'J', ":m '>+1<CR>gv=gv")
set('v', 'K', ":m '<-2<CR>gv=gv")

-- Move text up and down
set('x', '<A-j>', ":move '>+1<CR>gv-gv")
set('x', '<A-k>', ":move '<-2<CR>gv-gv")

-- greatest remap ever
set('x', '<leader>p', [["_dP]])
