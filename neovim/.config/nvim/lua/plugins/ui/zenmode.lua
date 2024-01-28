return {
  'folke/zen-mode.nvim',

  dependencies = {
    'folke/twilight.nvim',
  },

  cmd = 'ZenMode',

  keys = {
    {
      '<leader>z',
      function()
        require('zen-mode').toggle()
      end,
      desc = 'Toggle [Z]en Mode',
    },
  },

  opts = {
    window = {
      backdrop = 0.8,
      width = 83, -- This leaves enough space for sidebar columns + 80 characters
      height = 1,
      options = {
        signcolumn = 'no',
        foldcolumn = '0',
        list = false,
      },
    },
    plugins = {
      options = {
        enabled = true,
        colorcolumn = '',
        ruler = false,
        showcmd = false,
      },
      gitsigns = { enabled = true },
      twilight = { enabled = false },
      tmux = { enabled = true },
      diagnostics = { enabled = true },
    },
  },
}
