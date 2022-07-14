-- Auto install plugin manager
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if fn.empty(fn.glob(install_path)) > 0 then
	is_bootstrap = true
	vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
	vim.cmd [[packadd packer.nvim]]
end

local keymap_opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>sy', "<cmd>PackerSync<cr>", keymap_opts)
vim.keymap.set('n', '<leader>cl', "<cmd>PackerClean<cr>", keymap_opts)

local packer = require('packer')
packer.init({
	git = {
		clone_timeout = 1000, -- Timeout, in seconds, for git clones
	},
	luarocks = {
		python_cmd = 'python3' -- Set the python command to use for running hererocks
	},
})

-- Plugins configurations
return packer.startup(
	function(use)
		-- Let packer manage itself
		use {
			'wbthomason/packer.nvim',
			config = function()
				vim.cmd "autocmd BufWritePost init.lua source <afile> | PackerCompile"
			end
		}

		use {
			"navarasu/onedark.nvim",
			as = "theme",
			config = function()
				require 'plugins.minh.onedark-config'
			end
		}

		-- use { "Mofiqul/vscode.nvim",
		-- 	config = function()
		-- 		require 'plugins.minh.vscode-config'
		-- 	end
		-- }

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
				{
					'nvim-telescope/telescope-fzf-native.nvim', run = 'make', after = 'telescope.nvim',
					config = function()
						require('telescope').load_extension('fzf')
					end
				}
			},
			event = "BufEnter",
			config = function()
				require 'plugins.minh.telescope-config'
			end,
		}

		-- ThePrimeagen harpoon
		use {
			'ThePrimeagen/harpoon',
			requires = {
				'nvim-lua/plenary.nvim'
			},
			config = function()
				vim.keymap.set('n', "<leader>ha", function() require("harpoon.mark").add_file() end, keymap_opts)
				vim.keymap.set('n', '<leader>he', function() require("harpoon.ui").toggle_quick_menu() end, keymap_opts)

				vim.keymap.set('n', '<leader>h', function() require("harpoon.ui").nav_file(1) end, keymap_opts)
				vim.keymap.set('n', '<leader>j', function() require("harpoon.ui").nav_file(2) end, keymap_opts)
				vim.keymap.set('n', '<leader>k', function() require("harpoon.ui").nav_file(3) end, keymap_opts)
				vim.keymap.set('n', '<leader>l', function() require("harpoon.ui").nav_file(4) end, keymap_opts)
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
			end,
			requires = {
				'arkav/lualine-lsp-progress',
			}
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
						border = "none"
					}
				})
			end,
		}

		use { 'antoinemadec/FixCursorHold.nvim', config = function()
			vim.g.cursorhold_updatetime = 100
		end }

		use({
			'weilbith/nvim-code-action-menu',
			event = "BufEnter",
			cmd = 'CodeActionMenu',
			config = function()
				vim.g.code_action_menu_window_border = 'none'
				vim.g.code_action_menu_show_details = false
				vim.g.code_action_menu_show_diff = false
			end,
		})


		use { 'stevearc/dressing.nvim', config = function()
			require('dressing').setup({
				input = {
					-- Set to false to disable the vim.ui.input implementation
					enabled = true,

					-- Default prompt string
					default_prompt = "Input:",

					-- Can be 'left', 'right', or 'center'
					prompt_align = "left",

					-- When true, <Esc> will close the modal
					insert_only = true,

					-- These are passed to nvim_open_win
					anchor = "SW",
					border = "rounded",
					-- 'editor' and 'win' will default to being centered
					relative = "cursor",

					-- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
					prefer_width = 40,
					width = nil,
					-- min_width and max_width can be a list of mixed types.
					-- min_width = {20, 0.2} means "the greater of 20 columns or 20% of total"
					max_width = { 140, 0.9 },
					min_width = { 20, 0.2 },

					-- Window transparency (0-100)
					winblend = 10,
					-- Change default highlight groups (see :help winhl)
					winhighlight = "",

					override = function(conf)
						-- This is the config that will be passed to nvim_open_win.
						-- Change values here to customize the layout
						return conf
					end,

					-- see :help dressing_get_config
					get_config = nil,
				},
				select = {
					-- Set to false to disable the vim.ui.select implementation
					enabled = true,

					-- Priority list of preferred vim.select implementations
					backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },

					-- Trim trailing `:` from prompt
					trim_prompt = true,

					-- Options for telescope selector
					-- These are passed into the telescope picker directly. Can be used like:
					-- telescope = require('telescope.themes').get_ivy({...})
					telescope = nil,

					-- Options for fzf selector
					fzf = {
						window = {
							width = 0.5,
							height = 0.4,
						},
					},

					-- Options for fzf_lua selector
					fzf_lua = {
						winopts = {
							width = 0.5,
							height = 0.4,
						},
					},

					-- Options for nui Menu
					nui = {
						position = "50%",
						size = nil,
						relative = "editor",
						border = {
							style = "rounded",
						},
						buf_options = {
							swapfile = false,
							filetype = "DressingSelect",
						},
						win_options = {
							winblend = 10,
						},
						max_width = 80,
						max_height = 40,
						min_width = 40,
						min_height = 10,
					},

					-- Options for built-in selector
					builtin = {
						-- These are passed to nvim_open_win
						anchor = "NW",
						border = "rounded",
						-- 'editor' and 'win' will default to being centered
						relative = "editor",

						-- Window transparency (0-100)
						winblend = 10,
						-- Change default highlight groups (see :help winhl)
						winhighlight = "",

						-- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
						-- the min_ and max_ options can be a list of mixed types.
						-- max_width = {140, 0.8} means "the lesser of 140 columns or 80% of total"
						width = nil,
						max_width = { 140, 0.8 },
						min_width = { 40, 0.2 },
						height = nil,
						max_height = 0.9,
						min_height = { 10, 0.2 },

						override = function(conf)
							-- This is the config that will be passed to nvim_open_win.
							-- Change values here to customize the layout
							return conf
						end,
					},

					-- Used to override format_item. See :help dressing-format
					format_item_override = {},

					-- see :help dressing_get_config
					get_config = nil,
				},
			})
		end,
		}

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

		use {
			'akinsho/pubspec-assist.nvim',
			requires = 'plenary.nvim',
			rocks = {
				{
					'lyaml',
					server = 'http://rocks.moonscript.org',
					env = { YAML_DIR = '/usr/local/Cellar/libyaml/0.2.5/' },
				},
			},
			config = function()
				require('pubspec-assist').setup()
			end,
		}
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
				{ 'hrsh7th/cmp-copilot' },
				{ 'onsails/lspkind-nvim' },
			}
		}

		-- use { 'tzachar/cmp-tabnine',
		-- 	run = './install.sh',
		-- 	requires = 'hrsh7th/nvim-cmp',
		-- 	config = function()
		-- 		local tabnine = require('cmp_tabnine.config')
		-- 		tabnine:setup({
		-- 			max_lines = 1000;
		-- 			max_num_results = 20;
		-- 			sort = true;
		-- 			run_on_every_keystroke = true;
		-- 			snippet_placeholder = '..';
		-- 			ignored_file_types = { -- default is not to ignore
		-- 				-- uncomment to ignore in lua:
		-- 				-- lua = true
		-- 			};
		-- 			show_prediction_strength = false;
		-- 		})
		-- 	end
		-- }

		use { 'L3MON4D3/LuaSnip',
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
			requires = { 'rafamadriz/friendly-snippets' }

		}

		use { "akinsho/toggleterm.nvim",
			tag = 'v1.*',
			config = function()
				require 'plugins.minh.toggleterm-config'
			end
		}

		-- copilot
		use {
			'github/copilot.vim',
			event = "BufWinEnter",
			config = function()
				require 'plugins.minh.copilot'
			end
		}

		-- other
		use 'mtdl9/vim-log-highlighting'
		use 'szw/vim-g'
		use 'tpope/vim-sleuth'
		use 'tpope/vim-sensible'
		use 'tpope/vim-surround'
		use 'tpope/vim-rsi'
		use 'tpope/vim-unimpaired'
		use 'tpope/vim-eunuch'
		use 'tpope/vim-dispatch'
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

		-- game??
		use 'alec-gibson/nvim-tetris'

		-- Automatically set up your configuration after cloning packer.nvim
		-- Put this at the end after all plugins
		if is_bootstrap then
			require('packer').sync()
		end

	end
)
