return {
  'folke/trouble.nvim',

  dependencies = { 'nvim-tree/nvim-web-devicons' },

  cmd = { 'Trouble', 'TroubleToggle' },

  keys = {
    {
      '<leader>qq',
      '<CMD> TroubleToggle <CR>',
      desc = 'Toggle Diagnostics List (via Trouble plugin)',
    },
  },

  opts = { use_diagnostic_signs = true },
}
