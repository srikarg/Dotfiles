return {
  {
    'folke/which-key.nvim',
    opts = {
      spec = {
        {
          mode = { 'n', 'v' },
          { '<leader>gd', group = 'Diffview' },
        },
      },
    },
  },

  {
    'sindrets/diffview.nvim',

    cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },

    keys = {
      {
        '<leader>gdd',
        '<CMD> DiffviewOpen <CR>',
        desc = '  Show Git Diff',
      },

      {
        '<leader>gdf',
        '<CMD> DiffviewFileHistory % <CR>',
        desc = '  Show File History',
      },

      {
        '<leader>gdb',
        '<CMD> DiffviewFileHistory <CR>',
        desc = '  Show Branch History',
      },

      {
        '<leader>gdg',
        function()
          local word = vim.fn.expand('<cword>')
          vim.cmd('DiffviewFileHistory -G' .. word)
        end,
        desc = '  Search Git History For Current Word',
      },

      {
        '<leader>gdp',
        '<CMD> DiffviewOpen origin/HEAD...HEAD --imply-local <CR>',
        desc = '  Show PR History',
      },

      {
        '<leader>gdr',
        '<CMD> DiffviewRefresh <CR>',
        desc = '  Refresh Diff View',
      },

      {
        '<leader>gdc',
        '<CMD> DiffviewClose <CR>',
        desc = '  Close Diff View',
      },

      {
        '<leader>gdf',
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
  },
}
