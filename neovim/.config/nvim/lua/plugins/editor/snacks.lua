local gitActions = {
  actions = {
    ['diffview'] = function(picker)
      local currentCommit = picker:current().commit
      picker:close()
      vim.cmd('DiffviewOpen HEAD ' .. currentCommit)
    end,

    ['gitbrowse_open'] = function(picker)
      local currentCommit = picker:current().commit
      Snacks.gitbrowse.open({
        notify = false,
        what = 'commit',
        commit = currentCommit,
      })
    end,

    ['gitbrowse_copy'] = function(picker)
      local currentCommit = picker:current().commit
      local cwd = Snacks.git.get_root() or vim.fn.getcwd()
      local remote_url = vim.fn.system('git -C ' .. vim.fn.shellescape(cwd) .. ' remote get-url origin'):gsub('\n', '')
      if remote_url and remote_url ~= '' then
        local repo = Snacks.gitbrowse.get_repo(remote_url)
        local url = Snacks.gitbrowse.get_url(repo, { commit = currentCommit }, { what = 'commit' })
        vim.fn.setreg('+', url)
        Snacks.notify('Copied URL: ' .. url, { title = 'Git Browse' })
      end
    end,
  },
  win = {
    input = {
      keys = {
        ['<CR>'] = {
          'diffview',
          desc = 'Open in Diffview',
          mode = { 'n', 'i' },
        },

        ['o'] = {
          'gitbrowse_open',
          desc = 'Open Commit in Browser',
          mode = { 'n' },
        },

        ['y'] = {
          'gitbrowse_copy',
          desc = 'Copy Commit URL to Clipboard',
          mode = { 'n' },
        },
      },
    },
  },
}

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
      '<leader>gF',
      function()
        local word = vim.fn.expand('<cword>')
        Snacks.picker.git_log({
          search = word,
          live = true,
          on_show = function()
            vim.cmd.stopinsert()
          end,
        })
      end,
      desc = '  [F]ind Current Word in Git History',
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
              ignored = true,
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

  ---@module 'snacks'
  ---@type snacks.Config
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
        python = {
          keys = {
            ['source'] = {
              '<cr>',
              function(self)
                local command = { 'python', vim.api.nvim_buf_get_name(self.buf) }
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

    zen = {
      toggles = {
        dim = true,
        git_signs = false,
        mini_diff_signs = false,
        diagnostics = false,
        inlay_hints = false,
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

      sections = {
        { section = 'header' },
        { section = 'keys', gap = 0, padding = 1 },
        { icon = ' ', title = 'Recent Files', section = 'recent_files', cwd = true, indent = 2, padding = 1 },
        { section = 'startup' },
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
          keep_parents = true,
          layout = {
            preset = 'vscode',
            preview = 'main',
          },
        },

        explorer = {
          include = { '.env*' },
          hidden = true,
          -- https://github.com/folke/snacks.nvim/discussions/1372#discussioncomment-12461191
          win = {
            list = {
              keys = {
                ['Y'] = 'copy_path',
              },
            },
          },
          actions = {
            copy_path = function(_, item)
              local modify = vim.fn.fnamemodify
              local filepath = item.file
              local filename = modify(filepath, ':t')
              local values = {
                filepath,
                modify(filepath, ':.'),
                modify(filepath, ':~'),
                filename,
                modify(filename, ':r'),
                modify(filename, ':e'),
              }
              local items = {
                'Absolute path: ' .. values[1],
                'Path relative to CWD: ' .. values[2],
                'Path relative to HOME: ' .. values[3],
                'Filename: ' .. values[4],
              }
              if vim.fn.isdirectory(filepath) == 0 then
                vim.list_extend(items, {
                  'Filename without extension: ' .. values[5],
                  'Extension of the filename: ' .. values[6],
                })
              end
              vim.ui.select(items, { prompt = 'Choose to copy to clipboard:' }, function(choice, i)
                if not choice then
                  vim.notify('Selection cancelled')
                  return
                end
                if not i then
                  vim.notify('Invalid selection')
                  return
                end
                local result = values[i]
                vim.fn.setreg('"', result) -- Neovim unnamed register
                vim.fn.setreg('+', result) -- System clipboard
                vim.notify('Copied: ' .. result)
              end)
            end,
          },
        },

        git_log_file = gitActions,

        git_log = gitActions,
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

      zen = {
        width = 90,
        backdrop = {
          transparent = false,
        },
      },
    },
  },
}
