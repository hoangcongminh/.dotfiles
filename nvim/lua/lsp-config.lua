local lsp_installer = require('nvim-lsp-installer')
local lsp_mapping = require'lsp-keymaps'.map

-- Include the servers you want to have installed by default below
local servers = {
  "bashls",
  "pyright",
  "vuels",
  "yamlls",
  "tsserver",
  "sumneko_lua",
}

for _, name in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found and not server:is_installed() then
    print("Installing " .. name)
    server:install()
  end
end

local enhance_server_opts = {
  -- Provide settings that should only apply to the "eslintls" server
  ["eslintls"] = function(opts)
    opts.settings = {
      format = {
        enable = true,
      },
    }
  end,
}

  vim.diagnostic.config({
    virtual_text = true,
    signs = false,
    underline = true,
    update_in_insert = false,
    severity_sort = false,
  })

lsp_installer.on_server_ready(function(server)
  -- Specify the default options which we'll use to setup all servers
  local opts = {
    on_attach = lsp_mapping,
  }

  if enhance_server_opts[server.name] then
    -- Enhance the default opts with the server-specific ones
    enhance_server_opts[server.name](opts)
  end

  server:setup(opts)
end)

-- for _, lsp in ipairs(servers) do
--    nvim_lsp[lsp].setup {
--      on_attach = lsp_mapping,
--      flags = {
--        debounce_text_changes = 150,
--      },
--     settings = {
-- 	  Lua = {
-- 	      diagnostics = {
-- 		  globals = { 'vim','use' }
-- 	      }
-- 	  }
--       }
--    }
--  end

