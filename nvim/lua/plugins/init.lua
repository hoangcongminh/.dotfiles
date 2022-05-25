-- Auto install plugin manager
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
end

vim.cmd [[packadd packer.nvim]]

vim.keymap.set('n', '<leader>sy', "<cmd>PackerSync<cr>", { noremap = true, silent = true })
vim.keymap.set('n', '<leader>cl', "<cmd>PackerClean<cr>", { noremap = true, silent = true })

-- Plugins configurations
return require('packer').startup(
	function(use)
		-- Let packer manage itself
		use {
			'wbthomason/packer.nvim',
			config = function()
				vim.cmd "autocmd BufWritePost init.lua source <afile> | PackerCompile"
			end
		}

		use { "ellisonleao/gruvbox.nvim",
			config = function()
				require 'plugins.configs.color-scheme'
			end
		}

		-- treesitter
		use {
			'nvim-treesitter/nvim-treesitter',
			requires = {
				{ 'nvim-treesitter/playground', after = 'nvim-treesitter' },
				{ 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' },
				{ 'p00f/nvim-ts-rainbow', after = 'nvim-treesitter' },
				{ 'lewis6991/spellsitter.nvim', after = 'nvim-treesitter' }
			},
			run = ':TSUpdate',
			event = "BufWinEnter",
			config = function()
				require 'plugins.configs.treesitter'
			end,
		}

		-- telescope
		use {
			'nvim-telescope/telescope.nvim',
			requires = {
				'nvim-lua/plenary.nvim',
				{ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', after = 'telescope.nvim', config = function()
					require('telescope').load_extension('fzf')
					require("telescope").load_extension("notify")
				end }
			},
			event = "BufEnter",
			config = function()
				require 'plugins.configs.telescope-config'
			end,
		}

		-- dashboard
		use { 'glepnir/dashboard-nvim',
			config = function()
				require 'plugins.configs.dashboard-config'
			end,
		}

		-- type something badddd
		use {
			'phaazon/hop.nvim',
			branch = 'v1', -- optional but strongly recommended
			event = "BufEnter",
			config = function()
				require 'hop'.setup(
					{ keys = 'etovxqpdygfblzhckisuran' }
				)
				vim.keymap.set('n', 'fw', "<cmd>lua require'hop'.hint_words()<cr>", { silent = true })
				vim.keymap.set('n', 'fl', "<cmd>lua require'hop'.hint_lines()<cr>", { silent = true })
			end
		}

		-- File and folder management
		use {
			'kyazdani42/nvim-tree.lua',
			requires = 'kyazdani42/nvim-web-devicons',
			config = function()
				require 'plugins.configs.nvimtree'
			end,
		}

		-- git
		-- use 'tpope/vim-fugitive'
		use {
			'TimUntersberger/neogit',
			requires = {
				'nvim-lua/plenary.nvim',
				'sindrets/diffview.nvim'
			},
			keys = {
				'<LEADER>gg'
			},
			cmd = {
				'Neogit'
			},
			config = function()
				require('neogit').setup {
					disable_commit_confirmation = true,
					disable_context_highlighting = true,
					integrations = {
						diffview = true
					},
				}

				vim.keymap.set('n', '<leader>gg', ':Neogit kind=split<CR>', { noremap = true })
			end
		}
		use {
			'lewis6991/gitsigns.nvim',
			config = function()
				require 'plugins.configs.gitsigns-config'
			end,
			requires = {
				'nvim-lua/plenary.nvim'
			}
		}
		use { 'tpope/vim-rhubarb' } -- open github

		-- lualine & tabline
		use {
			'nvim-lualine/lualine.nvim',
			event = "BufWinEnter",
			config = function()
				require 'plugins.configs.lualine-config'
				vim.opt.laststatus = 3
			end,
			requires = { 'kyazdani42/nvim-web-devicons', opt = true }
		}
		use { 'akinsho/bufferline.nvim',
			tag = "v2.*",
			requires = 'kyazdani42/nvim-web-devicons',
			config = function()
				require 'plugins.configs.bufferline-config'
			end
		}

		-- icons
		use 'ryanoasis/vim-devicons'
		use 'kyazdani42/nvim-web-devicons'

		-- Show indent line
		use {
			"lukas-reineke/indent-blankline.nvim",
			event = "BufWinEnter",
			config = function()
				require("indent_blankline").setup {
					char = "▏",
					show_first_indent_level = false,
					show_trailing_blankline_indent = false,
				}
			end
		}

		-- comment
		use 'tpope/vim-commentary'

		--notify
		use { 'rcarriga/nvim-notify', config = function()
			require("notify").setup({
				-- Minimum level to show
				level = "info",

				-- Animation style (see below for details)
				stages = "fade_in_slide_out",

				-- Function called when a new window is opened, use for changing win settings/config
				on_open = nil,

				-- Function called when a window is closed
				on_close = nil,

				-- Render function for notifications. See notify-render()
				render = "default",

				-- Default timeout for notifications
				timeout = 5000,

				-- Max number of columns for messages
				max_width = nil,
				-- Max number of lines for a message
				max_height = nil,

				-- For stages that change opacity this is treated as the highlight behind the window
				-- Set this to either a highlight group, an RGB hex value e.g. "#000000" or a function returning an RGB code for dynamic values
				background_colour = "#000000",

				-- Minimum width for notification windows
				minimum_width = 50,

				-- Icons for the different levels
				icons = {
					ERROR = "?",
					WARN = "?",
					INFO = "?",
					DEBUG = "?",
					TRACE = "?",
				},
			})
		end }

		-- lsp
		use {
			'neovim/nvim-lspconfig',
			config = function()
				require 'plugins.configs.lsp-config'
			end,
		}
		use { 'williamboman/nvim-lsp-installer' }
		use { 'j-hui/fidget.nvim', config = function()
			require "fidget".setup {
				text = {
					spinner = "pipe", -- animation shown when tasks are ongoing
					done = "✔", -- character shown when all tasks are complete
					commenced = "Started", -- message shown when task starts
					completed = "Completed", -- message shown when task completes
				},
				window = {
					blend = 0, -- &winblend for the window
				},
			}
		end }
		require('packer').use({
			'weilbith/nvim-code-action-menu',
			event = "BufEnter",
			cmd = 'CodeActionMenu',
			config = function()
				vim.g.code_action_menu_window_border = 'none'
				vim.g.code_action_menu_show_details = false
				vim.g.code_action_menu_show_diff = false
			end,
		})

		-- debugger
		use {
			"rcarriga/nvim-dap-ui",
			requires = { "mfussenegger/nvim-dap" },
			after = 'nvim-dap',
			config = function()
				require 'plugins.configs.dap-config'
			end
		}

		-- flutter
		use 'Nash0x7E2/awesome-flutter-snippets'
		use {
			"akinsho/flutter-tools.nvim",
			requires = {
				"nvim-lua/plenary.nvim",
				'Nash0x7E2/awesome-flutter-snippets',
				'hrsh7th/cmp-nvim-lsp',
				'dart-lang/dart-vim-plugin'
			},
			config = function()
				require 'plugins.configs.flutter'
			end
		}


		-- completion
		use {
			'hrsh7th/nvim-cmp',
			config = function()
				require 'plugins.configs.cmp-config'
			end,
			requires = {
				{ 'hrsh7th/cmp-nvim-lsp' },
				{ 'hrsh7th/cmp-buffer' },
				{ 'hrsh7th/cmp-path' },
				{ 'hrsh7th/cmp-cmdline' },
				{ 'hrsh7th/cmp-vsnip' },
				{ 'hrsh7th/vim-vsnip' },
				{ 'hrsh7th/cmp-copilot' },
				{ 'rafamadriz/friendly-snippets' },
				{ 'onsails/lspkind-nvim' },
			}
		}
		use { 'tzachar/cmp-tabnine', run = './install.sh', requires = 'hrsh7th/nvim-cmp' }

		-- copilot
		use {
			'github/copilot.vim',
			event = "BufWinEnter",
			config = function()
				require 'plugins.configs.copilot'
			end
		}

		-- other
		use 'tpope/vim-sleuth'
		use 'tpope/vim-sensible'
		use 'tpope/vim-surround'
		use { 'romainl/vim-cool' } -- Auto hide search highlight
		use { 'norcalli/nvim-colorizer.lua', config = function()
			require 'colorizer'.setup()
		end }
		use { 'windwp/nvim-autopairs', config = function()
			require('nvim-autopairs').setup({
				disable_filetype = { "TelescopePrompt", "vim" },
			})
			-- If you want insert `(` after select function or method item
			local cmp_autopairs = require('nvim-autopairs.completion.cmp')
			local cmp = require('cmp')
			cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))


			-- add a lisp filetype (wrap my-function), FYI: Hardcoded = { "clojure", "clojurescript", "fennel", "janet" }
			cmp_autopairs.lisp[#cmp_autopairs.lisp + 1] = "racket"
		end
		}
		use { 'mg979/vim-visual-multi', branch = 'master' }
		use { 'szw/vim-maximizer',
			event = "BufWinEnter",
			config = function()
				vim.keymap.set('n', 'm', ":MaximizerToggle<CR>", { silent = true })
			end }

		-- game??
		use 'alec-gibson/nvim-tetris'

		-- Automatically set up your configuration after cloning packer.nvim
		-- Put this at the end after all plugins
		if packer_bootstrap then
			require('packer').sync()
		end

	end
)
