return {
  {
    'folke/trouble.nvim',

    keys = {
      {
        '<leader>cs',
        false,
      },
    },
  },

  {
    'SmiteshP/nvim-navbuddy',

    dependencies = {
      'neovim/nvim-lspconfig',
      'SmiteshP/nvim-navic',
      'MunifTanjim/nui.nvim',
    },

    opts = {
      lsp = {
        auto_attach = true,
      },
    },

    keys = {
      {
        '<leader>cs',
        function()
          require('nvim-navbuddy').open()
        end,
        desc = 'Symbols (Navbuddy)',
      },
    },
  },
}
