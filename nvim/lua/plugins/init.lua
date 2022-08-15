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

		--colorscheme
		use { "navarasu/onedark.nvim" }
		use { "Mofiqul/vscode.nvim" }
		use { "bluz71/vim-nightfly-guicolors" }

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
				{ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', after =
				'telescope.nvim', config = function()
					require('telescope').load_extension('fzf')
				end
				},
				{ 'nvim-telescope/telescope-ui-select.nvim', after = 'telescope.nvim',
					config = function()
						require('telescope').load_extension('ui-select')
					end
				},
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

				vim.keymap.set('n', '<leader>b', ":NvimTreeToggle<CR>", keymap_opts)
				vim.keymap.set('n', '<leader>n', ":NvimTreeFindFile<CR>", keymap_opts)
				vim.keymap.set('n', '<leader>r', ":NvimTreeRefresh<CR>", keymap_opts)
				require("nvim-tree").setup({
					sort_by = "case_sensitive",
					view = {
						adaptive_size = true,
						mappings = {
							list = {
								{ key = "u", action = "dir_up" },
							},
						},
					},
					renderer = {
						add_trailing = true,
						group_empty = true,
						highlight_git = true,
						full_name = true,
						indent_markers = {
							enable = true,
						},
						icons = {
							webdev_colors = true,
							git_placement = "before",
							padding = " ",
							symlink_arrow = " ➛ ",
							show = {
								file = true,
								folder = true,
								folder_arrow = true,
								git = true,
							},
							glyphs = {
								default = "",
								symlink = "",
								folder = {
									arrow_closed = "",
									arrow_open = "",
									default = "",
									open = "",
									empty = "",
									empty_open = "",
									symlink = "",
									symlink_open = "",
								},
								git = {
									unstaged = "",
									staged = "✓",
									unmerged = "",
									renamed = "➜",
									untracked = "U",
									deleted = "",
									ignored = "◌",
								},
							},
						},
						symlink_destination = true,
					},
					diagnostics = {
						enable = true,
						show_on_dirs = true,
					},
					filters = {
						dotfiles = false,
					},
					actions = {
						open_file = {
							quit_on_open = true,
						},
					}
				})
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
				'williamboman/mason.nvim',
				'williamboman/mason-lspconfig.nvim',
			},
			config = function()
				require 'plugins.minh.lsp-config'
			end
		}

		use({
			"glepnir/lspsaga.nvim",
			branch = "main",
			config = function()
				local saga = require("lspsaga")
				saga.init_lsp_saga({
					code_action_lightbulb = {
						enable = false,
						sign = true,
						enable_in_insert = true,
						sign_priority = 20,
						virtual_text = true,
					},
				})
			end,
		})

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
			vim.g.cursorhold_updatetime = 1000
		end }

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
			ft = { 'flutter', 'dart', 'yaml' },
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
				-- { 'hrsh7th/cmp-copilot' },
				{ 'andersevenrud/cmp-tmux' },
				{ 'onsails/lspkind-nvim' },
				{ 'tzachar/cmp-tabnine', run = './install.sh', requires = 'hrsh7th/nvim-cmp' }
			}
		}


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
		-- use {
		-- 	'github/copilot.vim',
		-- 	event = "BufWinEnter",
		-- 	config = function()
		-- 		require 'plugins.minh.copilot'
		-- 	end
		-- }

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
		end
		}

		use { 'mg979/vim-visual-multi', branch = 'master' }

		-- game??
		use {
			'alec-gibson/nvim-tetris',
			cmd = "Tetris",
		}

		-- Automatically set up your configuration after cloning packer.nvim
		-- Put this at the end after all plugins
		if is_bootstrap then
			require('packer').sync()
		end

	end
)
