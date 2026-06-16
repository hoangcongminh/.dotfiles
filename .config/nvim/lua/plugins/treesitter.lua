local ensure_installed = {
  'bash', 'cpp', 'dart', 'diff', 'git_config', 'gitcommit',
  'groovy', 'java', 'javascript', 'json', 'lua', 'markdown',
  'markdown_inline', 'python', 'tmux', 'toml', 'vim', 'vimdoc',
  'xml', 'yaml',
}

return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    event = { 'BufReadPre', 'BufNewFile' },
    build = ':TSUpdate',
    config = function()
      local ts = require('nvim-treesitter')
      ts.setup {}

      local have = {}
      for _, p in ipairs(ts.get_installed('parsers')) do
        have[p] = true
      end
      local missing = vim.tbl_filter(function(p) return not have[p] end, ensure_installed)
      if #missing > 0 then
        ts.install(missing)
      end

      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local ft = vim.bo[args.buf].filetype
          if ft == '' then return end
          -- Big-file guard: skip treesitter on files > 1 MB.
          -- getfsize returns -1 for buffers without a backing file (scratch,
          -- command-line), so the > comparison naturally lets those through.
          local name = vim.api.nvim_buf_get_name(args.buf)
          if name ~= '' and vim.fn.getfsize(name) > 1024 * 1024 then
            return
          end
          local lang = vim.treesitter.language.get_lang(ft) or ft
          local ok = pcall(vim.treesitter.start, args.buf, lang)
          if ok and ft == 'markdown' then
            -- keep vim regex highlighting on top of treesitter for markdown
            vim.bo[args.buf].syntax = 'ON'
          end
        end,
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('nvim-treesitter-textobjects').setup {
        select = { lookahead = true },
      }
      local function sel(obj)
        return function()
          require('nvim-treesitter-textobjects.select').select_textobject(obj, 'textobjects')
        end
      end
      vim.keymap.set({ 'x', 'o' }, 'af', sel('@function.outer'), { desc = 'a function' })
      vim.keymap.set({ 'x', 'o' }, 'if', sel('@function.inner'), { desc = 'inner function' })
      vim.keymap.set({ 'x', 'o' }, 'ac', sel('@class.outer'), { desc = 'a class' })
      vim.keymap.set({ 'x', 'o' }, 'ic', sel('@class.inner'), { desc = 'inner class' })
    end,
  },
}
