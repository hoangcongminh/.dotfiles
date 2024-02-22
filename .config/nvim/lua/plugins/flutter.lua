return {
  {
    'akinsho/flutter-tools.nvim',
    ft = { 'dart', 'yaml' },
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      'Nash0x7E2/awesome-flutter-snippets',
      'RobertBrunhage/flutter-riverpod-snippets',
    },
    config = function()
      local capabilities = vim.tbl_deep_extend('force', {}, vim.lsp.protocol.make_client_capabilities(), require('cmp_nvim_lsp').default_capabilities())

      local function on_attach(_, bufnr)
        require('telescope').load_extension 'flutter'

        local opts = { buffer = bufnr }
        local keymap = vim.keymap.set
        local command = vim.api.nvim_buf_create_user_command

        keymap('n', '<space>vs', function()
          vim.cmd.Telescope { 'flutter', 'fvm' }
        end, opts)
        keymap('n', '<space>cm', function()
          vim.cmd.Telescope { 'flutter', 'commands' }
        end, opts)
        keymap('n', '<space>fa', vim.cmd.FlutterRun, opts)
        keymap('n', '<space>fq', vim.cmd.FlutterQuit, opts)
        keymap('n', '<space>fR', vim.cmd.FlutterRestart, opts)
        keymap('n', '<space>dv', vim.cmd.FlutterDevices, opts)
        keymap('n', '<space>fl', vim.cmd.FlutterLogClear, opts)
        keymap('n', '<space>o', vim.cmd.FlutterOutlineToggle, opts)
        keymap('n', '<Space>rl', vim.cmd.FlutterReload, opts)
        keymap('n', '<space>fpg', vim.cmd.FlutterPubGet, opts)
        keymap('n', '<space>fd', vim.cmd.FlutterOpenLog, opts)

        command(bufnr, 'FlutterOpenLog', function()
          vim.cmd.vnew '__FLUTTER_DEV_LOG__'
        end, {})

        command(bufnr, 'FlutterBuildRunner', function()
          vim.cmd 'Dispatch flutter pub get; flutter pub run build_runner build --delete-conflicting-outputs'
        end, { force = true })

        command(bufnr, 'FlutterCLean', function()
          vim.cmd 'Dispatch flutter clean'
        end, { force = true })

        command(bufnr, 'FlutterRunRelease', function()
          vim.cmd 'Dispatch flutter clean; flutter pub get; flutter run --release'
        end, { force = true })

        OnAttachLsp(bufnr)
      end

      require('flutter-tools').setup {
        ui = {
          border = 'solid',
          notification_style = 'native', -- 'native'/'plugin'
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
            local dap = require 'dap'

            dap.adapters.dart = {
              type = 'executable',
              command = 'fvm',
              args = { 'flutter', 'debug_adapter' },
            }

            dap.configurations.dart = {
              {
                type = 'dart',
                request = 'launch',
                name = 'Launch Flutter Program',
                program = '${file}',
                cwd = '${workspaceFolder}',
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
          -- notify_errors = true,
          open_cmd = 'vnew',
        },
        dev_tools = {
          autostart = true,
          auto_open_browser = false,
        },
        outline = {
          open_cmd = 'vnew',
          auto_open = false,
        },
        lsp = {
          color = {
            enabled = true,
            background = false,
            background_color = nil,
            foreground = false,
            virtual_text = true,
            virtual_text_str = '■',
          },
          on_attach = on_attach,
          capabilities = capabilities,
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
            analysisExcludedFolders = { '**/.pub-cache/**', '**/fvm/**', '**/.dart_tool/**' },
            renameFilesWithClasses = 'always',
            enableSnippets = true,
            updateImportsOnRename = true,
          },
        },
      }
    end,
  },

  {
    'akinsho/pubspec-assist.nvim',
    ft = { 'dart', 'yaml' },
    event = 'BufEnter pubspec.yaml',
    config = function()
      require('pubspec-assist').setup()
    end,
  },
}
