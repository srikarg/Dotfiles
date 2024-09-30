return {
  'tzachar/highlight-undo.nvim',

  dependencies = 'folke/tokyonight.nvim',

  opts = {
    duration = 300,
    keymaps = {
      undo = {
        desc = 'Undo',
        hlgroup = 'HighlightUndo',
        mode = 'n',
        lhs = 'u',
      },
      redo = {
        desc = 'Redo',
        hlgroup = 'HighlightUndo',
        mode = 'n',
        lhs = '<C-r>',
      },
    },
    highlight_for_count = true,
  },
}
