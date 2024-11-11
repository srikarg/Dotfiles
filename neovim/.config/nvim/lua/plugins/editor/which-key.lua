return {
  'folke/which-key.nvim',

  keys = {
    {
      '<leader>d<space>',
      function()
        require('which-key').show({ keys = '<leader>d', loop = true })
      end,
      desc = 'Window Hydra Mode (which-key)',
    },
  },
}
