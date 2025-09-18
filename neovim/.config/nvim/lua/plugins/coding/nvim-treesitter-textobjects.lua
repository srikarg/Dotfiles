return {
  'nvim-treesitter/nvim-treesitter-textobjects',

  opts = {
    select = {
      lookahead = true,
      include_surrounding_whitespace = true,
    },
  },

  keys = {
    {
      '<leader>a',
      function()
        require('nvim-treesitter-textobjects.swap').swap_next('@parameter.inner')
      end,
      desc = 'Swap next parameter (inner)',
    },

    {
      '<leader>A',
      function()
        require('nvim-treesitter-textobjects.swap').swap_next('@parameter.outer')
      end,
      desc = 'Swap next parameter (outer)',
    },
  },
}
