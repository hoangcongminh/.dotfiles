vim.opt.background = "dark" -- or "light" for light mode

vim.cmd([[
 colorscheme gruvbox
 hi clear CursorLine
" custom style
 highlight Normal guibg=NONE ctermbg=NONE
 highlight LineNr guibg=NONE ctermbg=NONE
 highlight WinSeparator guibg=NONE ctermbg=NONE
 highlight SignColumn guibg=None ctermbg=NONE
 highlight EndOfBuffer guibg=NONE ctermbg=NONE
 highlight BufferTabpageFill guibg=none

 "highlight! CursorLine gui=underline cterm=underline guibg=none
 highlight! CursorLine guibg=#7c6f64
 highlight CursorLineNr guibg=NONE 
 highlight CursorColumn guibg=#7c6f64

 highlight SignColumn guibg=NONE ctermbg=NONE

 highlight NvimTreeNormal guibg=NONE
" highlight NvimTreeCursorline gui=underline cterm=underline guibg=NONE
 highlight LspDiagnosticsUnderlineInformation guifg=NONE
 highlight LspDiagnosticsUnderlineError guifg=NONE


 highlight Comment gui=italic
 highlight link GitSignsCurrentLineBlame Comment
 highlight FidgetTitle ctermfg=110 guifg=#61afef
 highlight FidgetTask guibg=NONE guifg=#FFFFFF cterm=bold
]])
