return {
  'ojroques/nvim-bufdel',

  keys = {
    {
      '<leader>x',
      '<CMD> BufDel <CR>',
      desc = 'Close Current Buffer',
      silent = true,
      nowait = true,
    },

    {
      '<leader>X',
      '<CMD> BufDelAll <CR>',
      desc = 'Close All Buffers',
      silent = true,
      nowait = true,
    },
  },

  opts = {
    next = 'tabs',
    quit = false,
  },
}
