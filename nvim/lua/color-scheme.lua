vim.cmd([[
let g:vscode_style = "dark"
let g:vscode_transparent = 0.8
let g:vscode_italic_comment = 1

colorscheme vscode

 set cursorline
 hi clear CursorLine
" custom style
 highlight Normal guibg=NONE ctermbg=NONE
 highlight LineNr guibg=NONE ctermbg=NONE
 highlight SignColumn guibg=NONE ctermbg=NONE
 highlight EndOfBuffer guibg=NONE ctermbg=NONE
 highlight NvimTreeNormal guibg=NONE
 highlight BufferTabpageFill guibg=none
 highlight! CursorLine gui=underline cterm=underline guibg=none
 highlight CursorLineNr guibg=NONE 
 highlight LspDiagnosticsUnderlineInformation guifg=NONE
 highlight LspDiagnosticsUnderlineError guifg=NONE
" highlight NvimTreeCursorline gui=underline cterm=underline guibg=NONE
 highlight Comment gui=italic
 highlight link GitSignsCurrentLineBlame Comment
 highlight FidgetTitle ctermfg=110 guifg=#6cb6eb
 highlight FidgetTask guibg=NONE guifg=#FFFFFF cterm=bold
]])
