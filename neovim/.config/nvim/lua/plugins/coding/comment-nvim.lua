return {
  'numToStr/Comment.nvim',

  event = 'VeryLazy',

  keys = {
    {
      '<leader>/',
      function()
        require('Comment.api').toggle.linewise.current()
      end,
      mode = 'n',
      desc = 'Toggle Linewise Comment',
    },

    {
      '<leader>/',
      "<ESC> <CMD> lua require('Comment.api').toggle.linewise(vim.fn.visualmode()) <CR>",
      mode = 'v',
      desc = 'Toggle Linewise Comment',
    },
  },

  opts = {
    ignore = '^$',
  },
}
