return {
  "https://github.com/akinsho/bufferline.nvim",
  event = "VeryLazy",
  config = function()
    require("bufferline").setup({
      options = {
        always_show_bufferline = false,
      },
    })
  end,
}
