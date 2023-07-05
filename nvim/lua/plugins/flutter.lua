local function config()
	local function on_attach(client, bufnr)
		require("telescope").load_extension("flutter")

		local opts = { noremap = true, silent = true, buffer = bufnr }
		local keymap = vim.keymap.set

		keymap("n", "<space>vs", function()
			vim.cmd.Telescope({ "flutter", "fvm" })
		end, opts)
		keymap("n", "<space>cm", function()
			vim.cmd.Telescope({ "flutter", "commands" })
		end, opts)
		keymap("n", "<space>fa", vim.cmd.FlutterRun, opts)
		keymap("n", "<space>fq", vim.cmd.FlutterQuit, opts)
		keymap("n", "<space>fR", vim.cmd.FlutterRestart, opts)
		keymap("n", "<space>dv", vim.cmd.FlutterDevices, opts)
		keymap("n", "<space>fl", vim.cmd.FlutterLogClear, opts)
		keymap("n", "<space>o", vim.cmd.FlutterOutlineToggle, opts)
		keymap("n", "<Space>rl", vim.cmd.FlutterReload, opts)
		keymap("n", "<space>fpg", vim.cmd.FlutterPubGet, opts)
		-- keymap('n', '<space>fm', vim.cmd.DartFmt, opts)
		-- keymap('n', '<space>fR', function()
		--   vim.cmd 'FlutterLogClear'
		--   vim.cmd 'FlutterRestart'
		-- end, opts)
		keymap("n", "<space>fd", vim.cmd.FlutterOpenLog, opts)

		vim.api.nvim_buf_create_user_command(bufnr, "FlutterOpenLog", function()
			vim.cmd.vnew("__FLUTTER_DEV_LOG__")
		end, {})

		vim.api.nvim_buf_create_user_command(bufnr, "FlutterBuildRunner", function()
			vim.cmd("Dispatch flutter pub get; flutter pub run build_runner build --delete-conflicting-outputs")
		end, { force = true })

		vim.api.nvim_buf_create_user_command(bufnr, "FlutterCLean", function()
			vim.cmd("Dispatch flutter clean")
		end, { force = true })

		vim.api.nvim_buf_create_user_command(bufnr, "FlutterRunRelease", function()
			vim.cmd("Dispatch flutter clean; flutter pub get; flutter run --release")
		end, { force = true })

		require("plugins.lsp.handlers").on_attach(client, bufnr)
	end

	require("flutter-tools").setup({
		ui = {
			border = require("global").border,
			notification_style = "plugin",
		},
		decorations = {
			statusline = {
				app_version = true,
				device = true,
				project_config = false,
			},
		},
		debugger = {
			enabled = false,
			run_via_dap = false,
			exception_breakpoints = {},
			register_configurations = function(path)
				local dap = require("dap")

				dap.adapters.dart = {
					type = "executable",
					command = "fvm",
					args = { "flutter", "debug_adapter" },
				}

				dap.configurations.dart = {
					{
						type = "dart",
						request = "launch",
						name = "Launch Flutter Program",
						program = "${file}",
						cwd = "${workspaceFolder}",
					},
				}
			end,
		},
		flutter_lookup_cmd = nil,
		fvm = true,
		widget_guides = {
			enabled = true,
		},
		closing_tags = {
			-- highlight = "ErrorMsg",
			-- prefix = ">",
			enabled = true,
		},
		dev_log = {
			enabled = true,
			notify_errors = true,
			open_cmd = "vnew",
		},
		dev_tools = {
			autostart = true,
			auto_open_browser = false,
		},
		outline = {
			open_cmd = "vnew",
			auto_open = false,
		},
		lsp = {
			color = {
				enabled = true,
				background = false,
				background_color = nil,
				foreground = false,
				virtual_text = true,
				virtual_text_str = "■",
			},
			on_attach = on_attach,
			capabilities = require("plugins.lsp.handlers").capabilities,
			root_dir = function()
				return vim.loop.cwd()
			end,
			init_options = {
				closingLabels = true,
				flutterOutline = true,
				outline = true,
				onlyAnalyzeProjectsWithOpenFiles = true,
				suggestFromUnimportedLibraries = true,
			},
			settings = {
				showTodos = true,
				completeFunctionCalls = true,
				analysisExcludedFolders = { "!**/.pub-cache/**", "!**/fvm/**", "!**/.dart_tool/**" },
				renameFilesWithClasses = "always",
				enableSnippets = true,
				updateImportsOnRename = true,
			},
		},
	})
end

return {
	-- flutter
	{
		"akinsho/flutter-tools.nvim",
		ft = { "flutter", "dart", "yaml" },
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim", -- optional for vim.ui.select
			"Nash0x7E2/awesome-flutter-snippets",
			"hrsh7th/cmp-nvim-lsp",
			"dart-lang/dart-vim-plugin",
			"RobertBrunhage/flutter-riverpod-snippets",
			-- 'eliasreis54/vim-bloc-plugin',
		},
		config = config,
	},

	{
		"akinsho/pubspec-assist.nvim",
		ft = { "dart" },
		event = "BufEnter pubspec.yaml",
		dependencies = "plenary.nvim",
		config = function()
			require("pubspec-assist").setup()
		end,
	},
}
