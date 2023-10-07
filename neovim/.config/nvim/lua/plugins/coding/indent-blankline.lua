return {
  'lukas-reineke/indent-blankline.nvim',

  event = 'VeryLazy',

  main = 'ibl',

  opts = {
    indent = {
      char = '│',
      tab_char = '│',
    },

    scope = {
      char = '│',
    },

    exclude = {
      filetypes = {
        'help',
        'NvimTree',
        'Trouble',
        'lazy',
        'mason',
        'notify',
      },
    },
  },
}
