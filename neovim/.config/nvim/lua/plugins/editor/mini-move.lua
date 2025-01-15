return {
  'echasnovski/mini.move',

  opts = {
    -- Module mappings. Use `''` (empty string) to disable one.
    mappings = {
      -- Move visual selection in Visual mode.
      left = '<c-m-h>',
      right = '<c-m-l>',
      down = '<c-m-j>',
      up = '<c-m-k>',

      -- Move current line in Normal mode
      line_left = '<c-m-h>',
      line_right = '<c-m-l>',
      line_down = '<c-m-j>',
      line_up = '<c-m-k>',
    },

    -- Options which control moving behavior
    options = {
      -- Automatically reindent selection during linewise vertical move
      reindent_linewise = true,
    },
  },
}
