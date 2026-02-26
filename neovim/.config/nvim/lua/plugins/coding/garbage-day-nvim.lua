return {
  'zeioth/garbage-day.nvim',

  event = 'VeryLazy',

  opts = {
    excluded_lsp_clients = {
      'copilot',
      'null-ls',
      'jdtls',
      'marksman',
      'lua_ls',
    },
  },
}
