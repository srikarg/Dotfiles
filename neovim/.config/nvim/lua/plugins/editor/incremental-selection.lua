return {
  {
    'folke/flash.nvim',

    keys = {
      { '<c-space>', false },
    },
  },

  {
    'MeanderingProgrammer/treesitter-modules.nvim',

    dependencies = { 'nvim-treesitter/nvim-treesitter' },

    ---@module 'treesitter-modules'
    ---@type ts.mod.UserConfig
    opts = {
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
    },
  },
}
