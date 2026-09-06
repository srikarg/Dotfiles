return {
  'christoomey/vim-tmux-navigator',

  lazy = false,

  keys = {
    {
      '<C-h>',
      '<CMD> TmuxNavigateLeft <CR>',
      desc = 'Navigate to Window on the Left',
    },

    {
      '<C-j>',
      '<CMD> TmuxNavigateDown <CR>',
      desc = 'Navigate to Window Below',
    },

    {
      '<C-k>',
      '<CMD> TmuxNavigateUp <CR>',
      desc = 'Navigate to Window Above',
    },
  },
}
