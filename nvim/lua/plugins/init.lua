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
				require 'plugins.minh.color-scheme'
			end
		}

		-- treesitter
		use {
			'hoangcongminh/nvim-treesitter',
			config = function()
				require 'plugins.minh.treesitter'
			end,
			run = ':TSUpdate',
			event = "BufWinEnter",
			requires = {
				{ 'nvim-treesitter/playground', after = 'nvim-treesitter' },
				{ 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' },
				{ 'p00f/nvim-ts-rainbow', after = 'nvim-treesitter' },
			},
		}

		-- telescope
		use {
			'nvim-telescope/telescope.nvim',
			requires = {
				'nvim-lua/plenary.nvim',
				{ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', after = 'telescope.nvim', config = function()
					require('telescope').load_extension('fzf')
				end }
			},
			event = "BufEnter",
			config = function()
				require 'plugins.minh.telescope-config'
			end,
		}

		-- navigate
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
				require 'plugins.minh.nvimtree'
			end,
		}

		-- git
		use 'tpope/vim-fugitive'
		use {
			'lewis6991/gitsigns.nvim',
			config = function()
				require 'plugins.minh.gitsigns-config'
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
				require 'plugins.minh.lualine-config'
				vim.opt.laststatus = 3
			end,
			requires = { 'kyazdani42/nvim-web-devicons', opt = true }
		}
		use { 'akinsho/bufferline.nvim',
			tag = "v2.*",
			requires = 'kyazdani42/nvim-web-devicons',
			config = function()
				require 'plugins.minh.bufferline-config'
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
					char = "┊",
					show_first_indent_level = false,
					show_trailing_blankline_indent = false,
				}
			end
		}

		-- comment
		use 'tpope/vim-commentary'

		-- lsp
		use {
			'junnplus/nvim-lsp-setup',
			requires = {
				'neovim/nvim-lspconfig',
				'williamboman/nvim-lsp-installer',
			},
			config = function()
				require 'plugins.minh.lsp-config'
			end
		}
		use {
			'ray-x/lsp_signature.nvim',
			config = function()
				require('lsp_signature').setup({
					bind = true,
					fix_pos = false,
					auto_close_after = 15, -- close after 15 seconds
					hint_enable = false,
					handler_opts = {
						border = "rounded"
					}
				})
			end,
		}
		use { 'antoinemadec/FixCursorHold.nvim', config = function()
			vim.g.cursorhold_updatetime = 100
		end }
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
				require 'plugins.minh.dap-config'
			end
		}

		-- flutter
		use {
			"akinsho/flutter-tools.nvim",
			requires = {
				"nvim-lua/plenary.nvim",
				'Nash0x7E2/awesome-flutter-snippets',
				'hrsh7th/cmp-nvim-lsp',
				'dart-lang/dart-vim-plugin'
			},
			config = function()
				require 'plugins.minh.flutter-tools'
			end
		}

		use { 'eliasreis54/vim-bloc-plugin' }

		--rust
		use { 'simrat39/rust-tools.nvim',
			require = {
				'nvim-lua/plenary.nvim',
				"nvim-lua/plenary.nvim",
			},
			config = function()
				require 'plugins.minh.rust-tools'
			end
		}

		-- completion
		use {
			'hrsh7th/nvim-cmp',
			config = function()
				require 'plugins.minh.cmp-config'
			end,
			requires = {
				{ 'hrsh7th/cmp-nvim-lsp' },
				{ 'hrsh7th/cmp-buffer' },
				{ 'hrsh7th/cmp-path' },
				{ 'hrsh7th/cmp-cmdline' },
				{ "hrsh7th/cmp-nvim-lua" },
				{ "hrsh7th/cmp-nvim-lsp-signature-help" },
				{ 'saadparwaiz1/cmp_luasnip' },
				{ 'dmitmel/cmp-cmdline-history' },
				{ 'ray-x/cmp-treesitter' },
				{ 'onsails/lspkind-nvim' },
			}
		}
		use { 'tzachar/cmp-tabnine',
			run = './install.sh',
			requires = 'hrsh7th/nvim-cmp',
			config = function()
				local tabnine = require('cmp_tabnine.config')
				tabnine:setup({
					max_lines = 1000;
					max_num_results = 20;
					sort = true;
					run_on_every_keystroke = true;
					snippet_placeholder = '..';
					ignored_file_types = { -- default is not to ignore
						-- uncomment to ignore in lua:
						-- lua = true
					};
					show_prediction_strength = false;
				})
			end
		}
		use { 'L3MON4D3/LuaSnip', config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end, requires = { 'rafamadriz/friendly-snippets' }

		}

		-- copilot
		-- use {
		-- 	'github/copilot.vim',
		-- 	event = "BufWinEnter",
		-- 	config = function()
		-- 		require 'plugins.minh.copilot'
		-- 	end
		-- }

		-- other
		use 'szw/vim-g'
		use 'tpope/vim-sleuth'
		use 'tpope/vim-sensible'
		use 'tpope/vim-surround'
		use 'tpope/vim-rsi'
		use 'tpope/vim-unimpaired'
		use 'tpope/vim-eunuch'
		use 'romainl/vim-cool' -- Auto hide search highlight
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
			-- cmp_autopairs.lisp[#cmp_autopairs.lisp + 1] = "racket"
		end
		}
		use { 'mg979/vim-visual-multi', branch = 'master' }
		use { 'szw/vim-maximizer',
			event = "BufWinEnter",
			config = function()
				vim.keymap.set('n', 'm', ":MaximizerToggle<CR>", { silent = true })
			end
		}

		-- game??
		use 'alec-gibson/nvim-tetris'

		-- Automatically set up your configuration after cloning packer.nvim
		-- Put this at the end after all plugins
		if packer_bootstrap then
			require('packer').sync()
		end

	end
)
