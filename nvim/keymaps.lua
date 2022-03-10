local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal --

keymap("n", "<leader>p", ":FZF<CR>", opts)
keymap("n", "<leader>/", ":Commentary<CR>", opts)
keymap("v", "<leader>/", ":Commentary<CR>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)
-- quickfix
keymap('n','<leader>co',':copen<CR>',opts)
keymap('n','<leader>cc',':ccl<CR>',opts)
keymap('n','<C-k>',':cp<CR>',opts)
keymap('n','<C-j>',':cn<CR>',opts)
-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
-- Update (:w if has edit)
keymap('n','<space>s',':update<CR>',opts)

-- Insert --

-- Press jk fast to exit insert mode
keymap("i", "jk", "<ESC>", opts)
-- Map Emacs like movement in Insert mode
-- keymap('i','<C-p>','<Up>',opts)
-- keymap('i','<C-n>','<Down>',opts)
keymap('i','<C-f>','<Right>',opts)
keymap('i','<C-b>','<Left>',opts)
-- keymap('i','<C-e>','<C-o>$',opts)
-- keymap('i','<C-a>','<C-o>^',opts)

-- Visual --

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --

-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
