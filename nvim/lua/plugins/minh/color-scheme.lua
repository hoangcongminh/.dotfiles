vim.g.nightflyCursorColor = 1
vim.g.nightflyNormalFloat = 1
vim.g.nightflyTransparent = 1
vim.g.nightflyUnderlineMatchParen = 1
vim.g.nightflyWinSeparator = 2

vim.cmd([[
colorscheme nightfly

 hi clear CursorLine
" custom style
 highlight Normal guibg=NONE ctermbg=NONE
 highlight LineNr guibg=NONE ctermbg=NONE
 highlight WinSeparator guibg=NONE ctermbg=NONE
 highlight SignColumn guibg=None ctermbg=NONE
 highlight EndOfBuffer guibg=NONE ctermbg=NONE
 highlight BufferTabpageFill guibg=none

 highlight! CursorLine gui=underline cterm=underline guibg=none
 "highlight! CursorLine guibg=#1d3b53
 highlight CursorLineNr guibg=NONE 
 "highlight CursorColumn guibg=#9ca1aa
 "highlight ColorColumn guibg=#1d3b53

 highlight SignColumn guibg=NONE ctermbg=NONE

 highlight NvimTreeNormal guibg=NONE
 "highlight NvimTreeCursorline guibg=#1d3b53

 highlight LspDiagnosticsUnderlineInformation guifg=NONE
 highlight LspDiagnosticsUnderlineError guifg=NONE


 highlight Comment gui=italic
 highlight link GitSignsCurrentLineBlame Comment
]])
