return {
  {
    'folke/lazydev.nvim',

    ft = 'lua',

    opts = {
      library = {
        vim.env.LAZY .. '/luvit-meta/library',
      },
    },
  },

  {
    'Bilal2453/luvit-meta',

    lazy = true,
  },
}
