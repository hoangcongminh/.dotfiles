local saga = require("lspsaga")
saga.init_lsp_saga({
  border_style = "single",
  saga_winblend = 0,
  code_action_lightbulb = {
    enable = false,
    sign = true,
    enable_in_insert = true,
    sign_priority = 20,
    virtual_text = true,
  },
})
