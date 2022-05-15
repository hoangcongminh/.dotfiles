--dracula
vim.g.dracula_show_end_of_buffer = 1
vim.g.dracula_transparent_bg = 0.7
vim.g.dracula_italic_comment = 1


vim.cmd([[
 colorscheme dracula
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
 highlight FidgetTitle ctermfg=110 guifg=#61afef
 highlight FidgetTask guibg=NONE guifg=#FFFFFF cterm=bold
 
 highlight BufferLineFill guifg=#44475a guibg=#44475a
 highlight BufferLineTabClose guifg=#44475a guibg=#44475a
]])
