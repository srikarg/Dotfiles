return {
  'danarth/sonarlint.nvim',

  ft = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
  },

  dependencies = {
    'neovim/nvim-lspconfig',
  },

  config = function()
    require('sonarlint').setup({
      server = {
        cmd = {
          'sonarlint-language-server',
          -- Ensure that sonarlint-language-server uses stdio channel
          '-stdio',
          '-analyzers',
          -- paths to the analyzers you need, using the JS jar below
          vim.fn.expand('$MASON/share/sonarlint-analyzers/sonarjs.jar'),
        },
        -- All settings are optional
        settings = {
          -- The default for sonarlint is {}, this is just an example
          sonarlint = {},
        },
      },
      filetypes = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
      },
    })
  end,
}
