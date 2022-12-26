vim.g.minh_colorscheme = "catppuccin"

function ColorschemeSetup()
    require 'configs.catppuccin'
    require 'configs.rose-pine'
    require 'configs.tokyo-night'

    vim.opt.background = "dark"
    vim.cmd("colorscheme " .. vim.g.minh_colorscheme)

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

    -- hl("WinSeparator", {
    --     fg = "#5eacd3"
    -- })

    -- hl("netrwDir", {
    --     fg = "#5eacd3"
    -- })

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
