-- Shorten function name
local keymap = vim.keymap.set

-- Keymap option
local opts = { noremap = true, silent = true }

keymap("n", "Q", "<nop>")

keymap("n", "<leader>ee", "oif err != null {<CR>}<Esc>Oreturn err", {})

-- Normal --
keymap("n", "<C-q>", ":quit<CR>", opts)
keymap("n", "<C-s>", ":update<CR>", opts)
keymap("n", "<leader>r", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- run tmux-sessionizer
keymap("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- Remap for dealing with word wrap
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Resize with arrows
keymap("n", "<M-J>", ":resize -2<CR>", opts)
keymap("n", "<M-K>", ":resize +2<CR>", opts)
keymap("n", "<M-H>", ":vertical resize -2<CR>", opts)
keymap("n", "<M-L>", ":vertical resize +2<CR>", opts)

-- quickfix
keymap("n", "<leader>co", ":copen<CR>", opts)
keymap("n", "<leader>cc", ":ccl<CR>", opts)
keymap("n", "<leader>ci", ":cli<CR>", opts)
keymap("n", "<leader>k", ":cp<CR>", opts)
keymap("n", "<leader>j", ":cn<CR>", opts)

keymap("n", "<leader>lo", ":lopen<CR>", opts)
keymap("n", "<leader>lc", ":lcl<CR>", opts)
keymap("n", "<leader>ll", ":lli<CR>", opts)

--buffers
keymap("n", "<tab>", ":bnext<CR>", opts)
keymap("n", "<s-tab>", ":bprevious<CR>", opts)

-- Insert --
-- Press jk fast to exit insert mode
keymap("i", "jk", "<ESC>", opts)
-- Map Emacs like movement in Insert mode
-- keymap('i','<C-p>','<Up>',opts)
-- keymap('i','<C-n>','<Down>',opts)
keymap("i", "<C-f>", "<Right>", opts)
keymap("i", "<C-b>", "<Left>", opts)
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
-- greatest remap ever
keymap("x", "<leader>p", '"_dP')

-- Netrw
keymap("n", "<leader>pv", ":Ex<CR>", opts)
