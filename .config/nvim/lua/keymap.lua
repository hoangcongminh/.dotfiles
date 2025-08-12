vim.g.mapleader = ' '

local function normal_mode(keymap, action, opts)
  vim.keymap.set('n', keymap, action, opts)
end

local function visual_mode(keymap, action)
  vim.keymap.set('v', keymap, action)
end

local function insert_mode(keymap, action)
  vim.keymap.set('i', keymap, action)
end

-- Run tmux-sessionizer
normal_mode('<C-f>', '<cmd>silent !tmux neww tmux-sessionizer<CR>')

-- normal_mode('<leader>pv', ':Explore<CR>')

normal_mode('<leader>r', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Keep stuff centred while moving around
normal_mode('<C-d>', '<C-d>zz')
normal_mode('<C-u>', '<C-u>zz')
normal_mode('n', 'nzzzv')
normal_mode('N', 'Nzzzv')

-- Quick fix list
normal_mode('<leader>co', ':copen<CR>')
normal_mode('<leader>cc', ':ccl<CR>')
normal_mode('<leader>ci', ':cli<CR>')
normal_mode('<C-j>', ':cn<CR>')
normal_mode('<C-k>', ':cp<CR>')

normal_mode('<leader>lo', ':lopen<CR>')
normal_mode('<leader>lc', ':lcl<CR>')
normal_mode('<leader>ll', ':lli<CR>')

-- Switch between tabs
normal_mode('<tab>', ':bnext<CR>')
normal_mode('<s-tab>', ':bprevious<CR>')

-- Enhance keymaps --
normal_mode('Y', 'yg$')
normal_mode('J', 'mzJ`z')

-- Press jk fast to exit insert mode
insert_mode('jk', '<ESC>')

-- Keep things highlighted after moving with < and >
visual_mode('<', '<gv')
visual_mode('>', '>gv')

-- Move stuff up and down in visual mode
visual_mode('J', ":m '>+1<CR>gv=gv")
visual_mode('K', ":m '<-2<CR>gv=gv")

-- greatest remap ever
vim.keymap.set('x', '<leader>p', [["_dP]])
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+Y]])
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"_d')
