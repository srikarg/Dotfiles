return {
  'kevinhwang91/nvim-ufo',

  dependencies = {
    'kevinhwang91/promise-async',

    -- Folding preview, by default h and l keys are used.
    -- On first press of h key, when cursor is on a closed fold, the preview will be shown.
    -- On second press the preview will be closed and fold will be opened.
    -- When preview is opened, the l key will close it and open fold. In all other cases these keys will work as usual.
    {
      'anuvyklack/fold-preview.nvim',
      dependencies = 'anuvyklack/keymap-amend.nvim',
      config = true,
    },

    {
      'luukvbaal/statuscol.nvim',
      config = function()
        local builtin = require('statuscol.builtin')

        require('statuscol').setup({
          relculright = true,
          segments = {
            { text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
            { text = { '%s' }, click = 'v:lua.ScSa' },
            { text = { builtin.lnumfunc, ' ' }, click = 'v:lua.ScLa' },
          },
        })
      end,
    },
  },

  event = 'BufReadPost',

  keys = {
    {
      'zR',
      function()
        require('ufo').openAllFolds()
      end,
      desc = 'Open all folds',
    },

    {
      'zM',
      function()
        require('ufo').closeAllFolds()
      end,
      desc = 'Close all folds',
    },
  },

  opts = {
    provider_selector = function(bufnr, filetype, buftype)
      return { 'treesitter', 'indent' }
    end,
  },
}
