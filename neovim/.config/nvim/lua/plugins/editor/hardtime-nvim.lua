return {
  'm4xshen/hardtime.nvim',

  event = 'VeryLazy',

  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
  },

  opts = {
    disable_mouse = false,
    hints = {
      ['y$'] = {
        message = function()
          return 'Use Y instead of y$'
        end,
        length = 2,
      },
      ['d$'] = {
        message = function()
          return 'Use D instead of d$'
        end,
        length = 2,
      },
      ['d[tTfF].i'] = { -- this matches d + {t/T/f/F} + {any character} + i
        message = function(keys) -- keys is a string of key strokes that matches the pattern
          return 'Use ' .. 'c' .. keys:sub(2, 3) .. ' instead of ' .. keys
          -- example: Use ct( instead of dt(i
        end,
        length = 4,
      },
    },
  },
}
