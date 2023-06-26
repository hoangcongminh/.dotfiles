local status_ok, flutter_tools = pcall(require, "flutter-tools")
if not status_ok then
  return
end

local pubspec_ok, pubspec_assist = pcall(require, "pubspec-assist")
if not pubspec_ok then
  return
end

local telescope_ok, telescope = pcall(require, "telescope")
if not telescope_ok then
  return
end

pubspec_assist.setup()

local function on_attach(client, bufnr)
  telescope.load_extension("flutter")

  local opts = { noremap = true, silent = true, buffer = bufnr }
  local keymap = vim.keymap.set

  keymap("n", "<space>vs", function()
    vim.cmd.Telescope { 'flutter', 'fvm' }
  end, opts)
  keymap("n", "<space>cm", function()
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
  -- keymap('n', '<space>fm', vim.cmd.DartFmt, opts)
  -- keymap('n', '<space>fR', function()
  --   vim.cmd 'FlutterLogClear'
  --   vim.cmd 'FlutterRestart'
  -- end, opts)
  keymap('n', '<space>fd', vim.cmd.FlutterOpenLog, opts)

  vim.api.nvim_buf_create_user_command(bufnr, 'FlutterOpenLog', function()
    vim.cmd.vnew '__FLUTTER_DEV_LOG__'
  end, {})

  vim.api.nvim_buf_create_user_command(bufnr, 'FlutterBuildRunner', function()
    vim.cmd 'Dispatch flutter pub get; flutter pub run build_runner build --delete-conflicting-outputs'
  end, { force = true })

  vim.api.nvim_buf_create_user_command(bufnr, 'FlutterCLean', function()
    vim.cmd 'Dispatch flutter clean'
  end, { force = true })

  vim.api.nvim_buf_create_user_command(bufnr, 'FlutterRunRelease', function()
    vim.cmd 'Dispatch flutter clean; flutter pub get; flutter run --release'
  end, { force = true })

  require("lsp.handlers").on_attach(client, bufnr)
end

flutter_tools.setup {
  ui = {
    border = "single",
    notification_style = 'plugin'
  },
  decorations = {
    statusline = {
      app_version = true,
      device = true,
      project_config = false,
    }
  },
  debugger = {
    enabled = false,
    run_via_dap = false,
    exception_breakpoints = {},
    register_configurations = function(path)
      local dap_status_ok, dap = pcall(require, "dap")
      if not dap_status_ok then
        return
      end

      dap.adapters.dart = {
        type = 'executable',
        command = 'fvm',
        args = { 'flutter', 'debug_adapter' }
      }

      dap.configurations.dart = {
        {
          type = "dart",
          request = "launch",
          name = "Launch Flutter Program",
          program = "${file}",
          cwd = "${workspaceFolder}",
        }
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
    enabled = true
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
    auto_open = false
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
    capabilities = require("lsp.handlers").capabilities,
    root_dir = function()
      return vim.loop.cwd()
    end,
    init_options = {
      closingLabels = true,
      flutterOutline = true,
      outline = true,
      onlyAnalyzeProjectsWithOpenFiles = true,
      suggestFromUnimportedLibraries = true
    },
    settings = {
      showTodos = true,
      completeFunctionCalls = true,
      analysisExcludedFolders = { "!**/.pub-cache/**", "!**/fvm/**", "!**/.dart_tool/**" },
      renameFilesWithClasses = "always",
      enableSnippets = true,
      updateImportsOnRename = true,
    }
  }
}
