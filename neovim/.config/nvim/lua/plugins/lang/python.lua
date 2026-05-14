return {
  {
    'neovim/nvim-lspconfig',

    -- Use Ty for Python LSP
    -- https://docs.astral.sh/ty/
    opts = {
      servers = {
        basedpyright = {
          enabled = false,
        },

        ty = {
          enabled = true,
        },
      },
    },
  },

  {
    'mason-org/mason.nvim',

    opts = {
      ensure_installed = {
        'ty',
      },
    },
  },
}
