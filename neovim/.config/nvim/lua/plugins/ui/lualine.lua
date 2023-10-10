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
            separator = '',
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
          { '%=', separator = '' },
          {
            function()
              return require('nvim-navic').get_location()
            end,
            cond = function()
              return package.loaded['nvim-navic']
                and require('nvim-navic').is_available()
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
