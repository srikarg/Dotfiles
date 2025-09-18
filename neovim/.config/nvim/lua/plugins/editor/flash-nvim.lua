return {
  'folke/flash.nvim',

  keys = {
    { '<c-space>', false },

    {
      '<C-CR>',

      mode = { 'n', 'o', 'x' },

      function()
        require('flash').treesitter({
          actions = {
            ['<TAB>'] = 'next',
            ['<S-TAB>'] = 'prev',
          },
        })
      end,

      desc = 'Treesitter Incremental Selection',
    },
  },
}
