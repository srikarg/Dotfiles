return {
  'nvim-treesitter/nvim-treesitter-context',

  event = { 'BufReadPost', 'BufNewFile' },

  keys = {
    {
      '<leader>cc',
      function()
        require('treesitter-context').go_to_context()
      end,
      desc = 'Jump to [C]urrent [C]ontext',
    },
  },

  dependencies = { 'nvim-treesitter/nvim-treesitter' },

  opts = {
    enable = true,
    max_lines = 10,
    line_numbers = true,
  },
}
