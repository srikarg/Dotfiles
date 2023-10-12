return {
  'iamcco/markdown-preview.nvim',

  ft = { 'markdown' },

  build = 'cd app && npm install && git reset --hard',

  keys = {
    {
      '<leader>mpt',
      '<CMD> MarkdownPreviewToggle <CR>',
      desc = '[T]oggle [M]arkdown [P]review',
    },
  },
}
