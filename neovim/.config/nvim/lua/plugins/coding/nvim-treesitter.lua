return {
  'nvim-treesitter/nvim-treesitter',

  opts = {
    auto_install = false,

    highlight = {
      enable = true,
      use_languagetree = true,
    },

    indent = {
      enable = true,
    },

    incremental_selection = {
      enable = true,
      -- Prevents these keybinds from functioning in command history mode
      -- (CTRL-F when in command mode) and other areas where the filetype is 'vim'
      disable = { 'vim' },
      keymaps = {
        init_selection = '<CR>',
        scope_incremental = '<CR>',
        node_incremental = '<TAB>',
        node_decremental = '<S-TAB>',
      },
    },

    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        include_surrounding_whitespace = true,
      },

      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          [']f'] = '@function.outer',
        },
        goto_next_end = {
          [']F'] = '@function.outer',
        },
        goto_previous_start = {
          ['[f'] = '@function.outer',
        },
        goto_previous_end = {
          ['[F'] = '@function.outer',
        },
      },

      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>A'] = '@parameter.inner',
        },
      },
    },
  },
}
