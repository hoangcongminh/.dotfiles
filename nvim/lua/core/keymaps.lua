-- Shorten function name
local keymap = vim.keymap.set

-- Keymap option
local opts = { noremap = true, silent = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal --
keymap("n", "<C-s>", ":write<CR>", opts)
keymap("n", "<C-q>", ":quit<CR>", opts)
keymap("n", "<leader>r", ":%s///g<LEFT><LEFT>", opts) -- replace
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

-- Remap for dealing with word wrap
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Resize with arrows
keymap("n", "<M-J>", ":resize -2<CR>", opts)
keymap("n", "<M-K>", ":resize +2<CR>", opts)
keymap("n", "<M-H>", ":vertical resize -2<CR>", opts)
keymap("n", "<M-L>", ":vertical resize +2<CR>", opts)

-- quickfix
keymap('n', '<leader>co', ':copen<CR>', opts)
keymap('n', '<leader>cc', ':ccl<CR>', opts)
keymap('n', '<leader>ci', ':cli<CR>', opts)
keymap('n', '<leader>k', ':cp<CR>', opts)
keymap('n', '<leader>j', ':cn<CR>', opts)

keymap('n', '<space>lo', ':lopen<CR>', opts)
keymap('n', '<space>lc', ':lcl<CR>', opts)
keymap('n', '<space>ll', ':lli<CR>', opts)
-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
-- Update (:w if has edit)
keymap('n', '<space>s', ':update<CR>', opts)

-- Insert --
-- Press jk fast to exit insert mode
keymap("i", "jk", "<ESC>", opts)
-- Map Emacs like movement in Insert mode
-- keymap('i','<C-p>','<Up>',opts)
-- keymap('i','<C-n>','<Down>',opts)
keymap('i', '<C-f>', '<Right>', opts)
keymap('i', '<C-b>', '<Left>', opts)
-- keymap('i','<C-e>','<C-o>$',opts)
-- keymap('i','<C-a>','<C-o>^',opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)

-- Visual Block --
-- Move text up and down
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Enhance keymaps --
keymap("n", "Y", "yg$", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)
keymap("n", "J", "mzJ`z", opts)

-- Plugins --

-- Packer
keymap('n', '<leader>sy', "<cmd>PackerSync<cr>", opts)
keymap('n', '<leader>cl', "<cmd>PackerClean<cr>", opts)

-- Commentary
keymap("n", "<leader>/", ":Commentary<CR>", opts)
keymap("v", "<leader>/", ":Commentary<CR>", opts)

-- Harpoon
keymap('n', '<leader>he', function() require("harpoon.ui").toggle_quick_menu() end, opts)
keymap('n', "<leader>ha", function() require("harpoon.mark").add_file() end, opts)

keymap('n', '<leader>h', function() require("harpoon.ui").nav_file(1) end, opts)
keymap('n', '<leader>j', function() require("harpoon.ui").nav_file(2) end, opts)
keymap('n', '<leader>k', function() require("harpoon.ui").nav_file(3) end, opts)
keymap('n', '<leader>l', function() require("harpoon.ui").nav_file(4) end, opts)

-- HOP
keymap('n', 'fw', "<cmd>lua require'hop'.hint_words()<cr>", { silent = true })
keymap('n', 'fl', "<cmd>lua require'hop'.hint_lines()<cr>", { silent = true })

-- ToggleTerm
keymap("n", "<leader>lg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)

-- NvimTree
keymap('n', '<leader>b', ":NvimTreeToggle<CR>", opts)
keymap('n', '<leader>n', ":NvimTreeFindFile<CR>", opts)
keymap('n', '<leader>r', ":NvimTreeRefresh<CR>", opts)

-- DAP
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)
