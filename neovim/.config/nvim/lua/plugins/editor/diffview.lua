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

    {
      '<leader>gvf',
      ':DiffviewFileHistory <CR>',
      mode = 'v',
      desc = '  Show File History',
    },
  },

  opts = function()
    local actions = require('diffview.actions')

    return {
      enhanced_diff_hl = true,

      view = {
        merge_tool = {
          layout = 'diff3_mixed',
          disable_diagnostics = true,
        },
      },

      keymaps = {
        file_panel = {
          {
            'n',
            '[c',
            actions.view_windo(function(layout_name, sym)
              if sym == 'b' then
                vim.cmd('norm! [c')
              end
            end),
          },
          {
            'n',
            ']c',
            actions.view_windo(function(layout_name, sym)
              if sym == 'b' then
                vim.cmd('norm! ]c')
              end
            end),
          },
          {
            'n',
            'x',
            actions.view_windo(function(layout_name, sym)
              if sym == 'b' then
                vim.cmd('diffget')
              end
            end),
          },
        },
      },
    }
  end,
}
