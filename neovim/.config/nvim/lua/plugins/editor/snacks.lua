return {
  'folke/snacks.nvim',

  keys = {
    { '<leader>n', false },

    {
      '<leader>N',
      function()
        Snacks.notifier.show_history()
      end,
      desc = 'Notification History',
    },
  },

  opts = {
    gitbrowse = {
      remote_patterns = {
        { '^(https?://sourcecode%.jnj%.com)/scm/(.-)/(.+)%.git$', '%1/projects/%2/repos/%3' },
        { '^(https?://.*)%.git$', '%1' },
        { '^git@(.+):(.+)%.git$', 'https://%1/%2' },
        { '^git@(.+):(.+)$', 'https://%1/%2' },
        { '^git@(.+)/(.+)$', 'https://%1/%2' },
        { '^ssh://git@(.*)$', 'https://%1' },
        { '^ssh://([^:/]+)(:%d+)/(.*)$', 'https://%1/%3' },
        { '^ssh://([^/]+)/(.*)$', 'https://%1/%2' },
        { 'ssh%.dev%.azure%.com/v3/(.*)/(.*)$', 'dev.azure.com/%1/_git/%2' },
        { '^https://%w*@(.*)', 'https://%1' },
        { '^git@(.*)', 'https://%1' },
        { ':%d+', '' },
        { '%.git$', '' },
      },
      url_patterns = {
        ['github%.com'] = {
          branch = '/tree/{branch}',
          file = '/blob/{branch}/{file}#L{line_start}-L{line_end}',
          commit = '/commit/{commit}',
        },
        ['gitlab%.com'] = {
          branch = '/-/tree/{branch}',
          file = '/-/blob/{branch}/{file}#L{line_start}-L{line_end}',
          commit = '/-/commit/{commit}',
        },
        ['bitbucket%.org'] = {
          branch = '/src/{branch}',
          file = '/src/{branch}/{file}#lines-{line_start}-L{line_end}',
          commit = '/commits/{commit}',
        },
        ['sourcecode%.jnj%.com'] = {
          branch = '/compare/commits?sourceBranch=refs%2Fheads%2F{branch}&targetBranch=refs%2Fheads%2Fdevelop',
          file = '/browse/{file}?at=refs%2Fheads%2F{branch}#{line_start}-{line_end}',
          commit = '/commits/{commit}',
        },
      },
    },

    scratch = {
      win_by_ft = {
        typescript = {
          keys = {
            ['source'] = {
              '<cr>',
              function(self)
                local command = { 'deno', vim.api.nvim_buf_get_name(self.buf) }
                local result = vim.system(command, { text = true }):wait()
                Snacks.notify.info(result.stdout)
              end,
              desc = 'Source buffer',
              mode = { 'n', 'x' },
            },
          },
        },
      },
    },

    dashboard = {
      preset = {
        keys = {
          { icon = ' ', key = 'f', desc = 'Find File', action = ":lua Snacks.dashboard.pick('files')" },
          { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
          { icon = ' ', key = 'g', desc = 'Find Text', action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = ' ', key = 'r', desc = 'Recent Files', action = ":lua Snacks.dashboard.pick('oldfiles')" },
          {
            icon = ' ',
            key = 'c',
            desc = 'Config',
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          { icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
          { icon = ' ', key = 'x', desc = 'Lazy Extras', action = ':LazyExtras' },
          { icon = '󰒲 ', key = 'l', desc = 'Lazy', action = ':Lazy' },
          { icon = '󰅩 ', key = 'L', desc = 'Leetcode', action = ':Leet' },
          { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
        },
      },
    },

    picker = {
      prompt = ' ',
      sources = {},
      layout = {
        cycle = true,
        --- Use the default layout or vertical if the window is too narrow
        preset = function()
          return vim.o.columns >= 120 and 'default' or 'vertical'
        end,
      },
      ui_select = true, -- replace `vim.ui.select` with the snacks picker
      previewers = {
        file = {
          max_size = 1024 * 1024, -- 1MB
          max_line_length = 500,
        },
      },
      win = {
        -- input window
        input = {
          keys = {
            -- Only overwrite existing keymaps that conflict with Aerospace
            -- tiling window manager
            ['<C-a-d>'] = { 'inspect', mode = { 'n', 'i' } },
            ['<C-a-m>'] = { 'toggle_maximize', mode = { 'i', 'n' } },
            ['<C-a-p>'] = { 'toggle_preview', mode = { 'i', 'n' } },
            ['<C-a-w>'] = { 'cycle_win', mode = { 'i', 'n' } },
            ['<C-a-i>'] = { 'toggle_ignored', mode = { 'i', 'n' } },
            ['<C-a-h>'] = { 'toggle_hidden', mode = { 'i', 'n' } },
          },
          b = {
            minipairs_disable = true,
          },
        },
        -- result list window
        list = {
          keys = {
            -- Only overwrite existing keymaps that conflict with Aerospace
            -- tiling window manager
            ['<C-a-d>'] = 'inspect',
            ['<C-a-w>'] = 'cycle_win',
          },
        },
        -- preview window
        preview = {
          minimal = false,
          wo = {
            cursorline = false,
            colorcolumn = '',
          },
          keys = {
            -- Only overwrite existing keymaps that conflict with Aerospace
            -- tiling window manager
            ['<C-a-w>'] = 'cycle_win',
          },
        },
      },
      ---@class snacks.picker.icons
      icons = {
        files = {
          enabled = true, -- show file icons
        },
        indent = {
          vertical = '│ ',
          middle = '├╴',
          last = '└╴',
        },
        ui = {
          live = '󰐰 ',
          selected = '● ',
          -- selected = " ",
        },
        git = {
          commit = '󰜘 ',
        },
        diagnostics = {
          Error = ' ',
          Warn = ' ',
          Hint = ' ',
          Info = ' ',
        },
        kinds = {
          Array = ' ',
          Boolean = '󰨙 ',
          Class = ' ',
          Color = ' ',
          Control = ' ',
          Collapsed = ' ',
          Constant = '󰏿 ',
          Constructor = ' ',
          Copilot = ' ',
          Enum = ' ',
          EnumMember = ' ',
          Event = ' ',
          Field = ' ',
          File = ' ',
          Folder = ' ',
          Function = '󰊕 ',
          Interface = ' ',
          Key = ' ',
          Keyword = ' ',
          Method = '󰊕 ',
          Module = ' ',
          Namespace = '󰦮 ',
          Null = ' ',
          Number = '󰎠 ',
          Object = ' ',
          Operator = ' ',
          Package = ' ',
          Property = ' ',
          Reference = ' ',
          Snippet = '󱄽 ',
          String = ' ',
          Struct = '󰆼 ',
          Text = ' ',
          TypeParameter = ' ',
          Unit = ' ',
          Uknown = ' ',
          Value = ' ',
          Variable = '󰀫 ',
        },
      },
    },
  },
}
