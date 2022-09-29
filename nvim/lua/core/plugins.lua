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
		clone_timeout = 600, -- Timeout, in seconds, for git clones
	},
	max_jobs = 10,
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

		-- increase startup speed
		use { "lewis6991/impatient.nvim" }

		--colorscheme
		use { "navarasu/onedark.nvim" }
		use { "Mofiqul/vscode.nvim" }
		use { 'folke/tokyonight.nvim' }
		use { "ellisonleao/gruvbox.nvim" }
		use { "catppuccin/nvim",
			as = "catppuccin",
			run = ":CatppuccinCompile" }

		-- treesitter
		use {
			'nvim-treesitter/nvim-treesitter',
			run = ':TSUpdate',
			event = "BufWinEnter",
			requires = {
				{ 'nvim-treesitter/playground', after = 'nvim-treesitter' },
				{ 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' },
				{ 'p00f/nvim-ts-rainbow', after = 'nvim-treesitter' },
			},
			config = function()
				require 'configs.treesitter'
			end
		}

		-- telescope
		use {
			'nvim-telescope/telescope.nvim',
			event = "BufEnter",
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
			config = function()
				require 'configs.telescope-config'
			end
		}

		-- ThePrimeagen harpoon
		use {
			'ThePrimeagen/harpoon',
			requires = {
				'nvim-lua/plenary.nvim'
			},
			event = "BufEnter",
			config = function()
				require 'configs.harpoon'
			end,
		}

		-- navigate
		use {
			'phaazon/hop.nvim',
			branch = 'v1', -- optional but strongly recommended
			event = "BufEnter",
			config = function()
				require 'configs.hop'
			end
		}

		-- File and folder management
		use {
			'kyazdani42/nvim-tree.lua',
			requires = 'kyazdani42/nvim-web-devicons',
			config = function()
				require 'configs.nvim-tree'
			end,
		}

		-- git
		use 'tpope/vim-fugitive'
		use {
			'lewis6991/gitsigns.nvim',
			event = "BufEnter",
			requires = {
				'nvim-lua/plenary.nvim'
			},
			config = function()
				require 'configs.gitsigns'
			end
		}
		use { 'tpope/vim-rhubarb' } -- open github

		-- lualine & tabline
		use {
			'nvim-lualine/lualine.nvim',
			event = "BufWinEnter",
			requires = {
				'arkav/lualine-lsp-progress',
			},
			config = function()
				require 'configs.lualine'
			end
		}

		-- icons
		use { "ryanoasis/vim-devicons",
			event = "VimEnter",
		}
		use { "kyazdani42/nvim-web-devicons",
			event = "VimEnter",
		}

		-- Show indent line
		use {
			"lukas-reineke/indent-blankline.nvim",
			event = "BufRead",
			config = function()
				require 'configs.indent-blankline'
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
				require 'configs.lsp-config'
			end
		}

		use({
			"glepnir/lspsaga.nvim",
			branch = "main",
			config = function()
				require 'configs.lspsaga'
			end
		})

		use {
			'ray-x/lsp_signature.nvim',
			config = function()
				require 'configs.lsp-signature'
			end
		}

		use {
			"antoinemadec/FixCursorHold.nvim",
			event = { "BufRead", "BufNewFile" },
			config = function() vim.g.cursorhold_updatetime = 100 end,
		}

		-- debugger
		-- use {
		-- 	"rcarriga/nvim-dap-ui",
		-- 	requires = { "mfussenegger/nvim-dap" },
		-- 	after = 'nvim-dap',
		-- 	config = function()
		-- 		require 'configs.dap-config'
		-- 	end
		-- }

		-- flutter
		use {
			"akinsho/flutter-tools.nvim",
			commit = '6b13345dd7ffe3b0a08536b8fadfa288af137616',
			ft = { 'flutter', 'dart', 'yaml' },
			requires = {
				"nvim-lua/plenary.nvim",
				'Nash0x7E2/awesome-flutter-snippets',
				'hrsh7th/cmp-nvim-lsp',
				'dart-lang/dart-vim-plugin',
				'RobertBrunhage/flutter-riverpod-snippets'
			},
			config = function()
				require 'configs.flutter-tools'
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
			end
		}

		--rust
		use {
			'simrat39/rust-tools.nvim',
			require = {
				'nvim-lua/plenary.nvim',
				"nvim-lua/plenary.nvim",
			},
			config = function()
				require 'configs.rust-tools'
			end
		}

		-- completion
		use {
			'hrsh7th/nvim-cmp',
			config = function()
				require 'configs.cmp'
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
				{ 'andersevenrud/cmp-tmux' },
				{ 'onsails/lspkind-nvim' },
				-- { 'tzachar/cmp-tabnine', run = './install.sh', requires = 'hrsh7th/nvim-cmp' }
			}
		}


		use {
			'L3MON4D3/LuaSnip',
			requires = { 'rafamadriz/friendly-snippets' },
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end

		}

		use {
			"akinsho/toggleterm.nvim",
			event = "BufEnter",
			-- cmd = "ToggleTerm",
			module = { "toggleterm", "toggleterm.terminal" },
			config = function()
				require 'configs.toggleterm'
			end
		}

		-- copilot
		use {
			'github/copilot.vim',
			event = "BufWinEnter",
			config = function()
				require 'configs.copilot'
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
		use { 'mg979/vim-visual-multi', branch = 'master' }

		use {
			'norcalli/nvim-colorizer.lua',
			event = { "BufRead", "BufNewFile" },
			config = function()
				require 'colorizer'.setup()
			end
		}

		use {
			'windwp/nvim-autopairs',
			event = "InsertEnter",
			config = function()
				require('nvim-autopairs').setup({
					disable_filetype = { "TelescopePrompt", "vim" },
				})
			end
		}

		-- Automatically set up your configuration after cloning packer.nvim
		-- Put this at the end after all plugins
		if is_bootstrap then
			require('packer').sync()
		end

	end
)
