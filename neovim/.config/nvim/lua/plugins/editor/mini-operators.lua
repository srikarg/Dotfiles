return {
  'echasnovski/mini.operators',

  opts = {
    -- Each entry configures one operator.
    -- `prefix` defines keys mapped during `setup()`: in Normal mode
    -- to operate on textobject and line, in Visual - on selection.

    -- Evaluate text and replace with output
    evaluate = {
      prefix = '<leader>g=',

      -- Function which does the evaluation
      func = nil,
    },

    -- Exchange text regions
    exchange = {
      prefix = '<leader>gX',

      -- Whether to reindent new text to match previous indent
      reindent_linewise = true,
    },

    -- Multiply (duplicate) text
    multiply = {
      prefix = '<leader>gM',

      -- Function which can modify text before multiplying
      func = nil,
    },

    -- Replace text with register
    replace = {
      prefix = '<leader>gR',

      -- Whether to reindent new text to match previous indent
      reindent_linewise = true,
    },

    -- Sort text
    sort = {
      prefix = '<leader>gS',

      -- Function which does the sort
      func = nil,
    },
  },
}
