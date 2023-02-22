local status_ok, flutter_tools = pcall(require, "flutter-tools")
if not status_ok then
  return
end

local telescope_ok, telescope = pcall(require, "telescope")
if not telescope_ok then
  return
end

local function on_attach(client, bufnr)
  telescope.load_extension("flutter")

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
    border = "rounded",
    notification_style = 'plugin'
  },
  decorations = {
    statusline = {
      app_version = true,
      device = true,
    }
  },
  debugger = {
    enabled = true,
    run_via_dap = false,
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
  flutter_lookup_cmd = nil,
  fvm = true,
  widget_guides = {
    enabled = true,
  },
  closing_tags = {
    enabled = true
  },
  dev_log = {
    enabled = true,
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
      foreground = false,
      virtual_text = true,
      virtual_text_str = "■",
    },
    on_attach = on_attach,
    capabilities = require("configs.lsp.handlers").capabilities,
    settings = {
      showTodos = true,
      completeFunctionCalls = true,
      renameFilesWithClasses = "always",
      enableSnippets = true,
      updateImportsOnRename = true,
      onlyAnalyzeProjectsWithOpenFiles = true,
      suggestFromUnimportedLibraries = true,
    }
  }
}
