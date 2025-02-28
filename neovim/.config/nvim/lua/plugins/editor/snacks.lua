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

    {
      '<leader><leader>',
      function()
        Snacks.picker.smart({
          multi = {
            'buffers',
            'recent',
            {
              finder = 'files',
              format = 'file',
              show_empty = true,
              hidden = true,
              ignored = false,
              follow = true,
              supports_live = true,
            },
          },
          filter = {
            cwd = true,
          },
        })
      end,
      desc = 'Smart Snacks Picker',
    },
  },

  opts = {
    gitbrowse = {
      what = 'permalink',
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
          permalink = '/blob/{commit}/{file}#L{line_start}-L{line_end}',
          commit = '/commit/{commit}',
        },
        ['gitlab%.com'] = {
          branch = '/-/tree/{branch}',
          file = '/-/blob/{branch}/{file}#L{line_start}-L{line_end}',
          permalink = '/-/blob/{commit}/{file}#L{line_start}-L{line_end}',
          commit = '/-/commit/{commit}',
        },
        ['bitbucket%.org'] = {
          branch = '/src/{branch}',
          file = '/src/{branch}/{file}#lines-{line_start}-L{line_end}',
          permalink = '/src/{commit}/{file}#lines-{line_start}-L{line_end}',
          commit = '/commits/{commit}',
        },
        ['sourcecode%.jnj%.com'] = {
          branch = '/compare/commits?sourceBranch=refs%2Fheads%2F{branch}&targetBranch=refs%2Fheads%2Fdevelop',
          file = '/browse/{file}?at=refs%2Fheads%2F{branch}#{line_start}-{line_end}',
          permalink = '/browse/{file}?at={commit}#{line_start}-{line_end}',
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
      formatters = {
        file = {
          -- Display filename before the file path
          filename_first = true,
        },
      },
      sources = {
        lsp_symbols = {
          layout = {
            preset = 'vscode',
            preview = 'main',
          },
        },

        explorer = {
          include = { '.env*' },
          hidden = true,
        },
      },
      layout = {
        cycle = true,
        --- Use the default layout or vertical if the window is too narrow
        preset = function()
          return vim.o.columns >= 120 and 'default' or 'vertical'
        end,
      },
      layouts = {
        select = {
          layout = {
            relative = 'cursor',
            width = 70,
            min_width = 0,
            row = 1,
          },
        },
      },
      -- Replace `vim.ui.select` with the snacks picker
      ui_select = true,
      previewers = {
        diff = {
          -- Use Neovim for previewing diffs (true) or use an external tool (false)
          builtin = false,
          cmd = { 'delta' },
        },
        git = {
          -- Use Neovim for previewing git output (true) or use git (false)
          builtin = false,
        },
        file = {
          -- 1MB
          max_size = 1024 * 1024,
          max_line_length = 500,
        },
      },
      win = {
        -- Input window
        input = {
          keys = {
            -- Overwrite default keymaps that conflict with Aerospace tiling
            -- window manager
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
        -- Result list window
        list = {
          keys = {
            -- Overwrite default keymaps that conflict with Aerospace tiling
            -- window manager
            ['<C-a-d>'] = 'inspect',
            ['<C-a-w>'] = 'cycle_win',
          },
        },
        -- Preview window
        preview = {
          minimal = false,
          wo = {
            colorcolumn = '',
            cursorline = false,
            foldcolumn = '0',
            number = true,
            relativenumber = false,
            signcolumn = 'no',
            statuscolumn = '',
          },
          keys = {
            -- Overwrite default keymaps that conflict with Aerospace tiling
            -- window manager
            ['<C-a-w>'] = 'cycle_win',
          },
        },
      },
    },

    styles = {
      lazygit = {
        width = 0,
        height = 0,
      },
    },
  },
}
