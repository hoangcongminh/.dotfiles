local impatient_ok, impatient = pcall(require, "impatient")
if impatient_ok then impatient.enable_profile() end

local ok, reload = pcall(require, 'plenary.reload')
RELOAD = ok and reload.reload_module or function(...)
    return ...
end

function R(name)
    RELOAD(name)
    return require(name)
end

R('core.plugins')
R('core.options')
R('core.autocommands')
R('core.keymaps')
R('core.colorscheme')

R("configs.lsp")
