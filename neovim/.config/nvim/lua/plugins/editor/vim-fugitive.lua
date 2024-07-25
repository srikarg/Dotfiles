return {
  'tpope/vim-fugitive',

  lazy = false,

  keys = {
    {
      '<leader>g/',
      ':vertical Git log --all -p -S ',
      'Git Pickaxe Search',
    },

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

    {
      '<leader>gY',
      ':GBrowse! <CR>',
      'Copy Git URL',
    },

    {
      '<leader>gY',
      ':GBrowse! <CR>',
      'Copy Git URL',
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
