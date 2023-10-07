local mappings = {
  add = 'gsa', -- Add surrounding in Normal and Visual modes
  delete = 'gsd', -- Delete surrounding
  find = 'gsf', -- Find surrounding (to the right)
  find_left = 'gsF', -- Find surrounding (to the left)
  highlight = 'gsh', -- Highlight surrounding
  replace = 'gsr', -- Replace surrounding
  update_n_lines = 'gsn', -- Update `n_lines`
}

return {
  'echasnovski/mini.surround',

  keys = {
    { mappings.add, desc = 'Add surrounding', mode = { 'n', 'v' } },
    { mappings.delete, desc = 'Delete surrounding' },
    { mappings.find, desc = 'Find right surrounding' },
    { mappings.find_left, desc = 'Find left surrounding' },
    { mappings.highlight, desc = 'Highlight surrounding' },
    { mappings.replace, desc = 'Replace surrounding' },
    {
      mappings.update_n_lines,
      desc = 'Update `MiniSurround.config.n_lines`',
    },
  },

  opts = {
    mappings = mappings,
  },
}
