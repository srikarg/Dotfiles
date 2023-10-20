return {
  'sindrets/diffview.nvim',

  cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },

  keys = {
    {
      '<leader>gvd',
      '<CMD> DiffviewOpen <CR>',
      desc = '  Show Git Diff',
    },

    {
      '<leader>gvf',
      '<CMD> DiffviewFileHistory % <CR>',
      desc = '  Show File History',
    },

    {
      '<leader>gvp',
      '<CMD> DiffviewOpen --cached <CR>',
      desc = '  Show Staged Diffs',
    },

    {
      '<leader>gvr',
      '<CMD> DiffviewRefresh <CR>',
      desc = '  Refresh Diff View',
    },

    {
      '<leader>gvc',
      '<CMD> DiffviewClose <CR>',
      desc = '  Close Diff View',
    },
  },

  opts = {
    enhanced_diff_hl = true,
    view = {
      merge_tool = {
        layout = 'diff3_mixed',
        disable_diagnostics = true,
      },
    },
  },
}
