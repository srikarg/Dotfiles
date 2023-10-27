return {
  'nvim-lualine/lualine.nvim',

  dependencies = {
    'SmiteshP/nvim-navic',
  },

  event = 'VeryLazy',

  opts = function()
    local icons = require('config').icons

    return {
      options = {
        theme = 'auto',
        globalstatus = true,
        ignore_focus = { 'NvimTree' },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = {
          {
            'filetype',
            icon_only = true,
            separator = '',
            padding = { left = 1, right = 0 },
          },
          {
            'filename',
            path = 1,
            symbols = { modified = '  ', readonly = '', unnamed = '' },
            separator = '',
          },
          {
            'diagnostics',
            separator = '|',
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
          {
            function()
              local status_ok, neotest = pcall(require, 'neotest')
              if not status_ok then
                return ''
              end
              local adapters = neotest.state.adapter_ids()
              if #adapters > 0 then
                local status = neotest.state.status_counts(adapters[1], {
                  buffer = tonumber(vim.api.nvim_buf_get_name(0)),
                })
                local sections = {
                  {
                    sign = icons.neotest.failed,
                    count = status and status.failed or '-',
                    base = 'NeotestFailedStatusLine',
                  },
                  {
                    sign = icons.neotest.running,
                    count = status and status.running or '-',
                    base = 'NeotestRunningStatusLine',
                  },
                  {
                    sign = icons.neotest.skipped,
                    count = status and status.skipped or '-',
                    base = 'NeotestSkippedStatusLine',
                  },
                  {
                    sign = icons.neotest.passed,
                    count = status and status.passed or '-',
                    base = 'NeotestPassedStatusLine',
                  },
                }

                local result = {}
                for _, section in ipairs(sections) do
                  if section.count > 0 then
                    table.insert(
                      result,
                      '%#'
                        .. section.base
                        .. '#'
                        .. section.sign
                        .. ' '
                        .. section.count
                    )
                  end
                end

                return table.concat(result, ' ')
              end
              return ''
            end,
          },
        },
        lualine_x = {
          {
            function()
              return require('noice').api.status.command.get()
            end,
            cond = function()
              return package.loaded['noice']
                and require('noice').api.status.command.has()
            end,
          },
          {
            function()
              return '  ' .. require('dap').status()
            end,
            cond = function()
              return package.loaded['dap'] and require('dap').status() ~= ''
            end,
          },
          {
            require('lazy.status').updates,
            cond = require('lazy.status').has_updates,
          },
          {
            'diff',
            symbols = {
              added = icons.git.added,
              modified = icons.git.modified,
              removed = icons.git.removed,
            },
          },
        },
        lualine_y = {
          { 'progress', separator = ' ', padding = { left = 1, right = 0 } },
          { 'location', padding = { left = 0, right = 1 } },
        },
        lualine_z = {
          function()
            return ' ' .. os.date('%I:%M %p')
          end,
        },
      },
      extensions = { 'nvim-tree', 'lazy', 'trouble', 'quickfix' },
    }
  end,
}
