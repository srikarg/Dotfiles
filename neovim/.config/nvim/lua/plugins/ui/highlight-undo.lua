return {
  'tzachar/highlight-undo.nvim',

  dependencies = 'folke/tokyonight.nvim',

  opts = {
    duration = 300,
    undo = {
      hlgroup = 'HighlightUndo',
      mode = 'n',
      lhs = 'u',
      map = 'silent undo',
      opts = {},
    },
    redo = {
      hlgroup = 'HighlightUndo',
      mode = 'n',
      lhs = '<C-r>',
      map = 'silent redo',
      opts = {},
    },
    highlight_for_count = true,
  },
}
