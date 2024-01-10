return {
  'folke/noice.nvim',

  event = 'VeryLazy',

  dependencies = {
    'MunifTanjim/nui.nvim',

    {
      'rcarriga/nvim-notify',

      opts = {
        timeout = 3000,
        stages = 'static',
        max_height = function()
          return math.floor(vim.o.lines * 0.75)
        end,
        max_width = function()
          return math.floor(vim.o.columns * 0.75)
        end,
      },
    },
  },

  opts = {
    lsp = {
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true,
      },
    },
    routes = {
      {
        filter = {
          event = 'msg_show',
          any = {
            { find = '%d+L, %d+B' },
            { find = '; after #%d+' },
            { find = '; before #%d+' },
          },
        },
        view = 'mini',
      },
      -- Show @recording messages
      {
        filter = { event = 'msg_showmode' },
        view = 'mini',
      },
      -- Skip session management info message from auto-session plugin
      -- https://github.com/rmagatti/auto-session/blob/51196ca66b38fc1660fdf50031cb0b31a199b7c9/lua/auto-session/init.lua#L859
      {
        filter = { find = 'Setting up autocmds' },
        opts = { skip = true },
      },
      -- Avoids unnecessary message when a LSP cannot provide information upon
      -- vim.lsp.buf.hover() in a file that has multiple LSPs attached.
      -- See https://github.com/neovim/nvim-lspconfig/issues/1931#issuecomment-1297599534
      -- for more information.
      {
        filter = { find = 'No information available' },
        opts = { skip = true },
      },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = true,
    },
  },

  keys = {
    {
      '<S-CR>',
      function()
        require('noice').redirect(vim.fn.getcmdline())
      end,
      mode = 'c',
      desc = 'Redirect Cmdline',
    },
    {
      '<leader>snl',
      function()
        require('noice').cmd('last')
      end,
      desc = 'Noice Last Message',
    },
    {
      '<leader>snh',
      function()
        require('noice').cmd('history')
      end,
      desc = 'Noice History',
    },
    {
      '<leader>sna',
      function()
        require('noice').cmd('all')
      end,
      desc = 'Noice All',
    },
    {
      '<leader>snd',
      function()
        require('noice').cmd('dismiss')
      end,
      desc = 'Dismiss All',
    },
    {
      '<c-f>',
      function()
        if not require('noice.lsp').scroll(4) then
          return '<c-f>'
        end
      end,
      silent = true,
      expr = true,
      desc = 'Scroll forward',
      mode = { 'i', 'n', 's' },
    },
    {
      '<c-b>',
      function()
        if not require('noice.lsp').scroll(-4) then
          return '<c-b>'
        end
      end,
      silent = true,
      expr = true,
      desc = 'Scroll backward',
      mode = { 'i', 'n', 's' },
    },
  },
}
