local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local function on_attach(client, bufnr)
  require("telescope").load_extension("flutter")

  local opts = { noremap = true, silent = true }

  -- local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local keymap = vim.keymap.set

  keymap("n", "<space>vs", ":Telescope flutter fvm<CR>", opts)
  keymap("n", "<space>cm", ":Telescope flutter commands<CR>", opts)

  keymap('n', '<space>fa', ':FlutterRun<CR>', opts)

  keymap('n', '<space>fq', ':FlutterQuit<CR>', opts)
  keymap('n', '<space>fp', ':FlutterCopyProfilerUrl<CR>', opts)
  keymap('n', '<space>dv', ':FlutterDevices<CR>', opts)
  keymap('n', '<space>fl', ':FlutterLogClear<CR>', opts)
  keymap('n', '<space>o', ':FlutterOutlineToggle<CR>', opts)
  keymap('n', '<Space>rl', ':FlutterReload<CR>', opts)
  keymap('n', '<space>fR', ':FlutterRestart<CR>', opts)
  keymap('n', '<space>fpg', ':FlutterPubGet<CR>', opts)
  keymap('n', '<space>fm', ':DartFmt<CR>', opts)

  vim.api.nvim_buf_create_user_command(bufnr, 'FlutterOpenLog', function()
    vim.cmd 'vsplit'
    vim.cmd 'buffer __FLUTTER_DEV_LOG__'
  end, { force = true })

  vim.api.nvim_buf_create_user_command(bufnr, 'FlutterBuildRunner', function()
    vim.cmd 'Dispatch flutter pub get; flutter pub run build_runner build --delete-conflicting-outputs'
  end, { force = true })

  vim.api.nvim_buf_create_user_command(bufnr, 'FlutterCLean', function()
    vim.cmd 'Dispatch flutter clean'
  end, { force = true })

  vim.api.nvim_buf_create_user_command(bufnr, 'FlutterRunRelease', function()
    vim.cmd 'Dispatch flutter clean; flutter pub get; flutter run --release'
  end, { force = true })

  require 'plugins.minh.lsp-keymaps'.map(client, bufnr)
end

require("flutter-tools").setup {
  ui = {
    -- the border type to use for all floating windows, the same options/formats
    -- used for ":h nvim_open_win" e.g. "single" | "shadow" | {<table-of-eight-chars>}
    border = "rounded",
    -- This determines whether notifications are show with `vim.notify` or with the plugin's custom UI
    -- please note that this option is eventually going to be deprecated and users will need to
    -- depend on plugins like `nvim-notify` instead.
    notification_style = 'plugin'
  },
  decorations = {
    statusline = {
      -- set to true to be able use the 'flutter_tools_decorations.app_version' in your statusline
      -- this will show the current version of the flutter app from the pubspec.yaml file
      app_version = true,
      -- set to true to be able use the 'flutter_tools_decorations.device' in your statusline
      -- this will show the currently running device if an application was started with a specific
      -- device
      device = true,
    }
  },
  debugger = { -- integrate with nvim dap + install dart code debugger
    enabled = true,
    run_via_dap = false, -- use dap instead of a plenary job to run flutter apps
    register_configurations = function(paths)
      local dap = require('dap')
      dap.adapters.dart = {
        type = "executable",
        command = "node",
        args = { os.getenv('HOME') .. "/.dotfiles/Dart-Code/out/dist/debug.js", "flutter" },
      }
      require("dap.ext.vscode").load_launchjs()
      dap.configurations.dart = {
        {
          type = "dart",
          request = "launch",
          name = "Launch flutter",
          dartSdkPath = paths.dart_sdk,
          flutterSdkPath = paths.flutter_sdk,
          -- The nvim-dap plugin populates this variable with the filename of the current buffer
          program = "${workspaceFolder}/lib/main.dart",
          -- The nvim-dap plugin populates this variable with the editor's current working directory
          cwd = "${workspaceFolder}",
          args = { '-d', '9FD96D5D-AC98-4D5A-8E73-802707579F42' }
        },
      }
    end,
  },
  -- flutter_path = "<full/path/if/needed>", -- <-- this takes priority over the lookup
  flutter_lookup_cmd = nil, -- example "dirname $(which flutter)" or "asdf where flutter"
  fvm = true, -- takes priority over path, uses <workspace>/.fvm/flutter_sdk if enabled
  widget_guides = {
    enabled = true,
  },
  closing_tags = {
    -- highlight = "ErrorMsg", -- highlight for the closing tag
    -- prefix = ">", -- character to use for close tag e.g. > Widget
    enabled = true -- set to false to disable
  },
  dev_log = {
    enabled = true,
    open_cmd = "vnew", -- command to use to open the log buffer
  },
  dev_tools = {
    autostart = true, -- autostart devtools server if not detected
    auto_open_browser = false, -- Automatically opens devtools in the browser
  },
  outline = {
    open_cmd = "vnew", -- command to use to open the outline buffer
    auto_open = false -- if true this will open the outline automatically when it is first populated
  },
  lsp = {
    color = { -- show the derived colours for dart variables
      enabled = true,
      background = false, -- highlight the background
      foreground = false, -- highlight the foreground
      virtual_text = true, -- show the highlight using virtual text
      virtual_text_str = "■", -- the virtual text character to highlight
    },
    on_attach = on_attach,
    capabilities = capabilities, -- e.g. lsp_status capabilities
    settings = {
      showTodos = true,
      completeFunctionCalls = true,
      -- analysisExcludedFolders = {<path-to-flutter-sdk-packages>}
      renameFilesWithClasses = "always", -- "always"
      enableSnippets = true,
      updateImportsOnRename = true,
    }
  }
}
