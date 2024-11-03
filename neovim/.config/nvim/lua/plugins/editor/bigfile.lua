return {
  'LunarVim/bigfile.nvim',

  opts = {
    -- Size of the file in MiB, the plugin rounds file sizes to the closest MiB
    filesize = 2,

    -- Features to disable
    features = {
      'indent_blankline',
      'illuminate',
      'lsp',
      'treesitter',
      'syntax',
      'matchparen',
      'vimopts',
      'filetype',
    },
  },
}
