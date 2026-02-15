return {
  'folke/sidekick.nvim',

  ---@class sidekick.Config
  opts = {
    cli = {
      ---@class sidekick.win.Opts
      win = {
        split = {
          width = 60,
          height = 40,
        },
      },
      ---@class sidekick.cli.Mux
      mux = {
        backend = vim.env.ZELLIJ and 'zellij' or 'tmux', -- default to tmux unless zellij is detected
        enabled = true,
        -- terminal: new sessions will be created for each CLI tool and shown in a Neovim terminal
        -- window: when run inside a terminal multiplexer, new sessions will be created in a new tab
        -- split: when run inside a terminal multiplexer, new sessions will be created in a new split
        -- NOTE: zellij only supports `terminal`
        create = 'split', ---@type "terminal"|"window"|"split"
        split = {
          vertical = true, -- vertical or horizontal split
          size = 0.4, -- size of the split (0-1 for percentage)
        },
      },
    },
  },

  keys = {
    {
      '<leader>aa',
      function()
        require('sidekick.cli').toggle({ name = 'opencode', focus = true })
      end,
      desc = 'Sidekick Toggle OpenCode',
    },
  },
}
