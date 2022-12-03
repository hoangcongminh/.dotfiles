local status_ok, flutter_tools = pcall(require, "flutter-tools")
if not status_ok then
  return
end

local function on_attach(client, bufnr)
  require("telescope").load_extension("flutter")

  local opts = { noremap = true, silent = true }
  local keymap = vim.keymap.set

  local toggle_dev_log = function()
    local wins = vim.api.nvim_list_wins()

    for _, id in pairs(wins) do
      local bufnr = vim.api.nvim_win_get_buf(id)
      if vim.api.nvim_buf_get_name(bufnr):match ".*/([^/]+)$" == "__FLUTTER_DEV_LOG__"
      then
        return vim.api.nvim_win_close(id, true)
      end
    end

    pcall(function()
      vim.api.nvim_command "vsplit + __FLUTTER_DEV_LOG__"
    end)
  end

  keymap("n", "<space>vs", ":Telescope flutter fvm<CR>", opts)
  keymap("n", "<space>cm", ":Telescope flutter commands<CR>", opts)
  keymap('n', '<space>fa', vim.cmd.FlutterRun, opts)
  keymap('n', '<space>fq', vim.cmd.FlutterQuit, opts)
  keymap('n', '<space>fp', vim.cmd.FlutterCopyProfilerUrl, opts)
  keymap('n', '<space>dv', vim.cmd.FlutterDevices, opts)
  keymap('n', '<space>fl', vim.cmd.FlutterLogClear, opts)
  keymap('n', '<space>o', vim.cmd.FlutterOutlineToggle, opts)
  keymap('n', '<Space>rl', vim.cmd.FlutterReload, opts)
  -- keymap('n', '<space>fR', vim.cmd.FlutterRestart, opts)
  keymap('n', '<space>fpg', vim.cmd.FlutterPubGet, opts)
  -- keymap('n', '<space>fm', ':DartFmt<CR>', opts)
  keymap('n', '<space>fR', function()
    vim.cmd 'FlutterLogClear'
    vim.cmd 'FlutterRestart'
  end, opts)
  keymap('n', '<space>fd', toggle_dev_log, opts)

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

  vim.api.nvim_buf_create_user_command(bufnr, 'FlutterOpenSimulator', function()
    vim.cmd 'Dispatch open -a Simulator.app'
  end, { force = true })

  require("configs.lsp.handlers").on_attach(client, bufnr)
end

flutter_tools.setup {
  ui = {
    -- the border type to use for all floating windows, the same options/formats
    -- used for ":h nvim_open_win" e.g. "single" | "shadow" | {<table-of-eight-chars>}
    border = "none",
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
    register_configurations = function()
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
    capabilities = require("configs.lsp.handlers").capabilities, -- e.g. lsp_status capabilities
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
