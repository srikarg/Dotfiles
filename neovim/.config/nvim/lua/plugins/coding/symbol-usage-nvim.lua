return {
  'Wansmer/symbol-usage.nvim',

  event = 'LspAttach',

  keys = {
    {
      '<leader>us',
      function()
        require('symbol-usage').toggle_globally()
      end,
      desc = 'Toggle [S]ymbol Usage Information',
    },
  },

  config = true,
}
