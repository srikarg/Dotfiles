return {
  'echasnovski/mini.pairs',

  event = 'VeryLazy',

  opts = {
    modes = {
      insert = true,
      command = true,
      terminal = false,
    },
    mappings = {
      ['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\].' },
      ['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\].' },
      ['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\].' },
      ['<'] = {
        action = 'open',
        pair = '<>',
        neigh_pattern = '\r.',
        register = { cr = false },
      },

      [')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\].' },
      [']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].' },
      ['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].' },
      ['>'] = { action = 'close', pair = '<>', register = { cr = false } },

      ['"'] = {
        action = 'closeopen',
        pair = '""',
        neigh_pattern = '[^\\].',
        register = { cr = false },
      },
      ["'"] = {
        action = 'closeopen',
        pair = "''",
        neigh_pattern = '[^%a\\].',
        register = { cr = false },
      },
      ['`'] = {
        action = 'closeopen',
        pair = '``',
        neigh_pattern = '[^\\].',
        register = { cr = false },
      },
    },
  },
}
