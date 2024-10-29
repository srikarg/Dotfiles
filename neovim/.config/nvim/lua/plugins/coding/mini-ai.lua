return {
  {
    'echasnovski/mini.ai',

    opts = function(_, opts)
      local ai = require('mini.ai')

      local custom_textobjects = {
        C = ai.gen_spec.treesitter({ a = '@comment.outer', i = '@comment.outer' }),
      }

      return vim.tbl_deep_extend('keep', opts, { custom_textobjects = custom_textobjects })
    end,
  },
}
