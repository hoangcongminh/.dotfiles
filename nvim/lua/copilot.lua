vim.cmd([[
  imap <silent><script><expr> <C-K> copilot#Accept("\<CR>")
  let g:copilot_no_tab_map = v:true
  let g:copilot_assume_mapped = v:true
]])
