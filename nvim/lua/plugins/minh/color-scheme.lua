vim.o.background = "dark"

vim.cmd([[
colorscheme vscode
" Enable transparent background
let g:vscode_transparency = 1
" Enable italic comment
let g:vscode_italic_comment = 1
" Disable nvim-tree background color
let g:vscode_disable_nvimtree_bg = v:true

 hi clear CursorLine
" custom style
 highlight Normal guibg=NONE ctermbg=NONE
 highlight LineNr guibg=NONE ctermbg=NONE
 highlight WinSeparator guibg=NONE ctermbg=NONE
 highlight SignColumn guibg=None ctermbg=NONE
 highlight EndOfBuffer guibg=NONE ctermbg=NONE
 highlight BufferTabpageFill guibg=none

 highlight! CursorLine gui=underline cterm=underline guibg=none
 "highlight! CursorLine guibg=grey
 highlight CursorLineNr guibg=NONE 
 "highlight CursorColumn guibg=grey
 highlight ColorColumn guibg=grey

 highlight SignColumn guibg=NONE ctermbg=NONE

 highlight NvimTreeNormal guibg=NONE
 highlight NvimTreeCursorline gui=underline cterm=underline guibg=none
 "highlight! CursorLine guibg=grey
 highlight LspDiagnosticsUnderlineInformation guifg=NONE
 highlight LspDiagnosticsUnderlineError guifg=NONE


 highlight Comment gui=italic
 highlight link GitSignsCurrentLineBlame Comment
]])
