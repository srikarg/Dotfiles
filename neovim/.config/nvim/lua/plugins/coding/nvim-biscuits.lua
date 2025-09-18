return {
  'code-biscuits/nvim-biscuits',

  -- TODO: Currently, nvim-biscuits doesn't seem to support the `main` branch of
  -- nvim-treesitter
  enabled = false,

  event = 'VeryLazy',

  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },

  opts = {
    cursor_line_only = true,
  },
}
