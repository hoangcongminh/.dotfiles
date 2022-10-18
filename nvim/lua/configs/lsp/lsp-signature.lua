local status_ok, lsp_signature = pcall(require, "lsp_signature")
if not status_ok then
  return
end

lsp_signature.setup({
  bind = true,
  fix_pos = false,
  auto_close_after = 15, -- close after 15 seconds
  hint_enable = false,
  handler_opts = {
    border = "none"
  }
})
