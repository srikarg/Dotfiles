return {
  {
    'neovim/nvim-lspconfig',

    opts = {
      inlay_hints = {
        enabled = false,
      },
    },
  },

  {
    'LazyVim/LazyVim',

    -- This controls which kinds of LSP symbols are shown querying them via a
    -- picker like the Snacks picker. We are updating the default to include
    -- constants and variables as well.
    opts = {
      kind_filter = {
        default = {
          'Class',
          'Constant',
          'Constructor',
          'Enum',
          'Field',
          'Function',
          'Interface',
          'Method',
          'Module',
          'Namespace',
          'Package',
          'Property',
          'Struct',
          'Trait',
          'Variable',
        },
      },
    },
  },
}
