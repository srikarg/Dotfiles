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
    },
  },
}
