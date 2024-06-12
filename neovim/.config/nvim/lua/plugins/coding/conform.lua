return {
  'stevearc/conform.nvim',

  opts = {
    formatters_by_ft = {
      -- Use the "*" filetype to run formatters on all filetypes.
      ['*'] = { 'trim_whitespace', 'trim_newlines' },
    },
  },
}
