return {
    {
        "nvim-lua/plenary.nvim",
        lazy = true,
    },

    {
        "rose-pine/neovim",
        as = "rose-pine",
        config = function()
            require('rose-pine').setup({
                variant = "moon",
                styles = {
                    bold = true,
                    italic = true,
                    transparency = true,
                },
            })
            vim.cmd.colorscheme("rose-pine")
        end
    },

    {
        -- copilot
        "github/copilot.vim",
        event = { "BufReadPost", "BufNewFile" },
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        event = "VeryLazy",
        config = function()
            require("ibl").setup({
                indent = {
                    char = "▏",
                    tab_char = "→",
                },
                scope = {
                    enabled = false,
                },
            })
        end,
    },

    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
    },

    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup()
        end,
    },

    -- Git
    {
        "https://github.com/NeogitOrg/neogit",
        cmd = "Neogit",
        config = function()
            require("neogit").setup({
                disable_commit_confirmation = true,
            })
        end,
    },

    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        config = function()
            require("gitsigns").setup({
                current_line_blame = true,
            })
        end,
    },

    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        config = function()
            require("Comment").setup()
        end,
    },

    {
        -- highlight todos comments
        "folke/todo-comments.nvim",
        cmd = { "TodoTrouble", "TodoTelescope" },
        event = { "BufReadPost", "BufNewFile" },
        dependencies = "nvim-lua/plenary.nvim",
        opts = {}
    },

    -- icons
    { "ryanoasis/vim-devicons" },
    { "kyazdani42/nvim-web-devicons" },

    -- other
    { "mtdl9/vim-log-highlighting",  event = "VeryLazy" },
    { "tpope/vim-sleuth",            event = "VeryLazy" },
    { "tpope/vim-surround",          event = "VeryLazy" },
    { "tpope/vim-rsi",               event = "VeryLazy" },
    { "tpope/vim-unimpaired",        event = "VeryLazy" },
    { "tpope/vim-eunuch",            event = "VeryLazy" },
    { "tpope/vim-dispatch",          event = "VeryLazy" },
}
