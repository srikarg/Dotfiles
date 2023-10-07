return {
  'danymat/neogen',

  dependencies = { 'nvim-treesitter/nvim-treesitter' },

  keys = {
    {
      '<leader>gd',
      function()
        require('neogen').generate({
          -- The annotation type to generate. Currently supported: func, class, type, file
          type = 'func',
        })
      end,
      desc = '[G]enerate [D]ocumentation for Current Function',
    },
  },

  config = true,
}
