-- local colors = {
--   -- bg = '#303446',
--   bg = "none",
--   fg = "#bbc2cf",
--   yellow = "#E5C890",
--   cyan = "#81C8BE",
--   darkblue = "#8CAAEE",
--   green = "#A6D189",
--   orange = "#EF9F76",
--   violet = "#BABBF1",
--   magenta = "#F4B8E4",
--   blue = "#85C1DC",
--   red = "#E78284",
-- }

local colors = {
  bg = "none",
  fg = "#e0def4",
  yellow = "#f6c177",
  cyan = "#31748f",
  darkblue = "#081633",
  green = "#98BB6C",
  orange = "#FF8800",
  violet = "#938AA9",
  magenta = "#c4a7e7",
  blue = "#9ccfd8",
  red = "#eb6f92",
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand("%:p:h")
    local gitdir = vim.fn.finddir(".git", filepath .. ";")
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- Config
local config = {
  options = {
    globalstatus = true,
    component_separators = "",
    section_separators = "",
    theme = {
      normal = { c = { fg = colors.fg, bg = colors.bg } },
      inactive = { c = { fg = colors.fg, bg = colors.bg } },
    },
  },
  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_v = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

ins_left({
  function()
    return "▊"
  end,
  color = { fg = colors.blue }, -- Sets highlighting of component
  left_padding = 0,            -- We don't need space before this
})

ins_left({
  function()
    local mode_color = {
      n = colors.red,
      i = colors.green,
      v = colors.blue,
      [""] = colors.blue,
      V = colors.blue,
      c = colors.magenta,
      no = colors.red,
      s = colors.orange,
      S = colors.orange,
      [""] = colors.orange,
      ic = colors.yellow,
      R = colors.violet,
      Rv = colors.violet,
      cv = colors.red,
      ce = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      ["r?"] = colors.cyan,
      ["!"] = colors.red,
      t = colors.red,
    }
    vim.api.nvim_command("hi! LualineMode guifg=" .. mode_color[vim.fn.mode()] .. " guibg=" .. colors.bg)
    -- return ''
    return vim.fn.mode()
  end,
  color = "LualineMode",
  left_padding = 0,
})

ins_left({
  "filename",
  condition = conditions.buffer_not_empty,
  path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
  -- color = { bg = colors.magenta, fg = colors.bg, gui = 'bold' }
})

-- ins_left {
--   'filesize',
--   cond = conditions.buffer_not_empty,
-- }

ins_left({ "location" })

ins_left({
  "diagnostics",
  sources = { "nvim_lsp" },
  symbols = { error = " ", warn = " ", info = " " },
  color_error = colors.red,
  color_warn = colors.yellow,
  color_info = colors.cyan,
})

ins_left({
  function()
    return "[" .. vim.g.flutter_tools_decorations.app_version .. "]"
  end,
  color = { fg = colors.blue, gui = "bold" },
})

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left({
  function()
    return "%="
  end,
})

ins_left({
  -- Lsp server name .
  function()
    local msg = "No Active Lsp"
    local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return msg
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end,
  icon = " LSP:",
  color = { fg = colors.fg, gui = "bold" },
})

-- ins_right {
--   function()
--     return vim.g.flutter_tools_decorations.app_version
--   end,
--   icon = 'version:',
--   color = { fg = colors.orange, gui = 'bold' },
-- }

-- ins_right {
--   'o:encoding', -- option component same as &encoding in viml
--   upper = true, -- I'm not sure why it's upper case either ;)
--   condition = conditions.hide_in_width,
--   color = { fg = colors.green, gui = 'bold' }
-- }

-- ins_right {
--   'fileformat',
--   upper = true,
--   icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
--   color = { fg = colors.green, gui = 'bold' }
-- }

ins_right({ "filetype" })

ins_right({
  "branch",
  icon = "",
  condition = conditions.check_git_workspace,
  color = { fg = colors.magenta, gui = "bold" },
})

ins_right({
  "diff",
  symbols = { added = " ", modified = "柳 ", removed = " " },
  color_added = colors.green,
  color_modified = colors.orange,
  color_removed = colors.red,
  condition = conditions.hide_in_width,
})

ins_right({
  function()
    return "▊"
  end,
  color = { fg = colors.blue },
  right_padding = 0,
})

-- return {
--   -- lualine & winbar
--   "nvim-lualine/lualine.nvim",
--   event = "VeryLazy",
--   config = function()
--     require("lualine").setup(config)
--   end,
-- }

return {}