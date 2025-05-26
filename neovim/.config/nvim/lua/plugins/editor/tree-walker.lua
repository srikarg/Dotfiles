return {
  'aaronik/treewalker.nvim',

  opts = {
    -- Whether to briefly highlight the node after jumping to it
    highlight = true,

    -- How long should above highlight last (in ms)
    highlight_duration = 250,

    -- The color of the above highlight. Must be a valid vim highlight group.
    -- (see :h highlight-group for options)
    highlight_group = 'CursorLine',

    -- Whether the plugin adds movements to the jumplist -- true | false | 'left'
    --  true: All movements more than 1 line are added to the jumplist. This is the default,
    --        and is meant to cover most use cases. It's modeled on how { and } natively add
    --        to the jumplist.
    --  false: Treewalker does not add to the jumplist at all
    --  "left": Treewalker only adds :Treewalker Left to the jumplist. This is usually the most
    --          likely one to be confusing, so it has its own mode.
    jumplist = true,
  },

  keys = {
    { '<leader>T', '', desc = '+Treewalker' },

    {
      '<leader>T<space>',
      function()
        require('which-key').show({ keys = '<leader>T', loop = true })
      end,
      desc = 'Treewalker Hydra Mode (which-key)',
    },

    {
      '<leader>TK',
      '<CMD>Treewalker SwapUp<CR>',
      desc = 'Treewalker Swap Up',
      silent = true,
    },

    {
      '<leader>TJ',
      '<CMD>Treewalker SwapDown<CR>',
      desc = 'Treewalker Swap Down',
      silent = true,
    },

    {
      '<leader>TH',
      '<CMD>Treewalker SwapLeft<CR>',
      desc = 'Treewalker Swap Left',
      silent = true,
    },

    {
      '<leader>TL',
      '<CMD>Treewalker SwapRight<CR>',
      desc = 'Treewalker Swap Right',
      silent = true,
    },

    {
      '<leader>Tk',
      '<CMD>Treewalker Up<CR>',
      desc = 'Treewalker Up',
      silent = true,
    },

    {
      '<leader>Tj',
      '<CMD>Treewalker Down<CR>',
      desc = 'Treewalker Down',
      silent = true,
    },

    {
      '<leader>Th',
      '<CMD>Treewalker Left<CR>',
      desc = 'Treewalker Left',
      silent = true,
    },

    {
      '<leader>Tl',
      '<CMD>Treewalker Right<CR>',
      desc = 'Treewalker Right',
      silent = true,
    },
  },
}
