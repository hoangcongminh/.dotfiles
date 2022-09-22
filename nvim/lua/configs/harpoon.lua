local keymap_opts = { noremap = true, silent = true }

vim.keymap.set('n', "<leader>ha", function() require("harpoon.mark").add_file() end, keymap_opts)
vim.keymap.set('n', '<leader>he', function() require("harpoon.ui").toggle_quick_menu() end, keymap_opts)

vim.keymap.set('n', '<leader>h', function() require("harpoon.ui").nav_file(1) end, keymap_opts)
vim.keymap.set('n', '<leader>j', function() require("harpoon.ui").nav_file(2) end, keymap_opts)
vim.keymap.set('n', '<leader>k', function() require("harpoon.ui").nav_file(3) end, keymap_opts)
vim.keymap.set('n', '<leader>l', function() require("harpoon.ui").nav_file(4) end, keymap_opts)
