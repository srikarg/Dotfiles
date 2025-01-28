return {
  'nvim-neo-tree/neo-tree.nvim',

  opts = {
    enable_diagnostics = false,

    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        always_show_by_pattern = {
          '.env*',
        },
        never_show_by_pattern = {
          '.DS_Store',
        },
      },
      group_empty_dirs = true,
      hijack_netrw_behavior = 'disabled',
    },

    window = {
      mappings = {
        ['y'] = {
          function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            local relative_path = vim.fn.fnamemodify(path, ':.')
            vim.fn.setreg('+', relative_path, 'c')
          end,
          desc = 'Copy Relative Path to Clipboard',
        },
      },
    },
  },
}
