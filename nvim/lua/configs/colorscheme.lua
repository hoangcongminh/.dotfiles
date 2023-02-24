vim.g.minh_colorscheme = "catppuccin"

local status_ok, catppuccin = pcall(require, "catppuccin")
if not status_ok then
    return
end

vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
local colors = require("catppuccin.palettes").get_palette()
colors.none = "NONE"

catppuccin.setup({
    transparent_background = true,
    term_colors = true,
    compile = {
        enabled = true,
        path = vim.fn.stdpath("cache") .. "/catppuccin",
    },
    dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
    },
    styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = { "italic" },
        keywords = { "bold" },
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    integrations = {
        mason = true,
        nvimtree = true,
        navic = {
            enabled = true,
            custom_bg = "NONE"
        },
        -- For various plugins integrations see https://github.com/catppuccin/nvim#integrations
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = { "italic" },
                hints = { "italic" },
                warnings = { "italic" },
                information = { "italic" },
            },
            underlines = {
                errors = { "underline" },
                hints = { "underline" },
                warnings = { "underline" },
                information = { "underline" },
            },
            dap = { enabled = true, enable_ui = true },
        },
    },
    color_overrides = {},
    highlight_overrides = {},
    custom_highlights = {
        Comment = { fg = colors.overlay1 },
        LineNr = { fg = colors.overlay1 },
        CursorLine = { bg = colors.none },
        CursorLineNr = { fg = colors.lavender },
        VertSplit = { fg = colors.pink },
        DiagnosticVirtualTextError = { bg = colors.none },
        DiagnosticVirtualTextWarn = { bg = colors.none },
        DiagnosticVirtualTextInfo = { bg = colors.none },
        DiagnosticVirtualTextHint = { bg = colors.none },
    }
})

function ColorschemeSetup()
    vim.opt.background = "dark"
    local colorscheme = "catppuccin"
    vim.cmd.colorscheme(colorscheme)

    local hl = function(thing, opts)
        vim.api.nvim_set_hl(0, thing, opts)
    end

    hl("SignColumn", {
        bg = "none",
    })

    hl("ColorColumn", {
        ctermbg = 0,
        bg = "#333333",
    })

    hl("CursorLine", {
        underline = true,
        bg = "None",
        fg = "None",
    })

    hl("CursorLineNR", {
        bg = "None"
    })

    hl("Normal", {
        bg = "none"
    })

    hl("NormalFloat", {
        bg = "none"
    })

    hl("LineNr", {
        fg = "#5eacd3"
    })

    hl("WinSeparator", {
        fg = "#5eacd3"
    })

    hl("netrwDir", {
        fg = "#5eacd3"
    })

end

ColorschemeSetup()

local M = {}

M.lualine_colors = {
    -- bg = '#303446',
    bg = 'none',
    fg = '#bbc2cf',
    yellow = "#E5C890",
    cyan = "#81C8BE",
    darkblue = "#8CAAEE",
    green = "#A6D189",
    orange = "#EF9F76",
    violet = "#BABBF1",
    magenta = "#F4B8E4",
    blue = "#85C1DC",
    red = "#E78284",
}

return M
