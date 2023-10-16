return {
  'tpope/vim-fugitive',

  lazy = false,

  keys = {
    {
      '<leader>go',
      ':.GBrowse <CR>',
      '[G]it [O]pen URL for Current Line',
    },

    {
      '<leader>go',
      ':GBrowse <CR>',
      '[G]it [O]pen URL for Current Line(s)',
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
