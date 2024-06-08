return {
  'tpope/vim-fugitive',

  lazy = false,

  keys = {
    {
      '<leader>gB',
      ':.GBrowse <CR>',
      'Git Browse',
    },

    {
      '<leader>gB',
      ':GBrowse <CR>',
      'Git Browse',
      mode = 'v',
    },
  },

  dependencies = {
    'tpope/vim-rhubarb',

    {
      'tommcdo/vim-fubitive',

      config = function()
        vim.g.fubitive_domain_pattern = 'sourcecode\\.jnj\\.com'
      end,
    },
  },
}
