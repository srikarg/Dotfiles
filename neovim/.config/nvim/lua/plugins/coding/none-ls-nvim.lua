return {
  'nvimtools/none-ls.nvim',

  ft = 'go',

  dependencies = {
    'williamboman/mason.nvim',
  },

  opts = function()
    local null_ls = require('null-ls')

    return {
      debug = true,

      sources = {
        null_ls.builtins.code_actions.gomodifytags,
        null_ls.builtins.code_actions.impl,
      },
    }
  end,
}
