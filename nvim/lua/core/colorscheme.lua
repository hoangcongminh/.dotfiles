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
        bg = "#2B79A0",
    })

    hl("CursorLineNR", {
        bg = "None"
    })

    hl("Normal", {
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
