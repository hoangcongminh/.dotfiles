vim.g.vscode_style = "dark"
vim.g.vscode_transparent = 0.8
vim.g.vscode_italic_comment = 1

vim.cmd([[
 colorscheme vscode
 set cursorline
 hi clear CursorLine
" custom style
 highlight Normal guibg=NONE ctermbg=NONE
 highlight LineNr guibg=NONE ctermbg=NONE
 highlight WinSeparator guibg=NONE ctermbg=NONE
 highlight SignColumn guibg=None ctermbg=NONE
 highlight EndOfBuffer guibg=NONE ctermbg=NONE
 highlight BufferTabpageFill guibg=none
 highlight! CursorLine gui=underline cterm=underline guibg=none
 highlight CursorLineNr guibg=NONE 

 highlight NvimTreeNormal guibg=NONE
" highlight NvimTreeCursorline gui=underline cterm=underline guibg=NONE
 highlight LspDiagnosticsUnderlineInformation guifg=NONE
 highlight LspDiagnosticsUnderlineError guifg=NONE
 highlight Comment gui=italic
 highlight link GitSignsCurrentLineBlame Comment
 highlight FidgetTitle ctermfg=110 guifg=#6cb6eb
 highlight FidgetTask guibg=NONE guifg=#FFFFFF cterm=bold
]])
