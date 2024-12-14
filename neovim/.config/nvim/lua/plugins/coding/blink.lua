return {
  'saghen/blink.cmp',

  opts = {
    completion = {
      ghost_text = {
        enabled = true,
      },
    },

    signature = { enabled = true },

    keymap = {
      preset = 'enter',

      -- Disable the <C-space> keymap configured by LazyVim and use <C-l> instead, since
      -- <C-space> is my Tmux prefix keymap.
      ['<C-space>'] = {},
      ['<C-l>'] = { 'show', 'show_documentation', 'hide_documentation' },

      -- Disable the <C-y> "select and accept" keymap configured by LazyVim
      ['<C-y>'] = {},
    },
  },
}
