return {
  'ojroques/nvim-bufdel',

  keys = {
    {
      '<leader>q',
      '<CMD> BufDel <CR>',
      desc = 'Close Current Buffer',
      silent = true,
      nowait = true,
    },

    {
      '<leader>Q',
      '<CMD> BufDelAll <CR>',
      desc = 'Close All Buffers',
      silent = true,
      nowait = true,
    },
  },

  opts = {
    next = 'tabs',
    quit = true,
  },
}
