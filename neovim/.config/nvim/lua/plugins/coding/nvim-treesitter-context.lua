return {
  'nvim-treesitter/nvim-treesitter-context',

  keys = {
    {
      '<leader>C',
      function()
        require('treesitter-context').go_to_context()
      end,
      desc = 'Jump to Current [C]ontext',
    },
  },
}
