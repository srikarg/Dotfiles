local inlayHintsEnabled = false

return {
  'pmizio/typescript-tools.nvim',

  dependencies = {
    'nvim-lua/plenary.nvim',
    'neovim/nvim-lspconfig',
  },

  ft = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
  },

  keys = {
    {
      '<leader>ui',
      function()
        inlayHintsEnabled = not inlayHintsEnabled
        print('Setting inlay hints to: ' .. tostring(inlayHintsEnabled))
        vim.lsp.inlay_hint.enable(inlayHintsEnabled, nil)
      end,
      mode = 'n',
      desc = 'Toggle [I]nlay Hints',
    },

    {
      '<leader>co',
      '<CMD> TSToolsOrganizeImports <CR>',
      mode = 'n',
      desc = 'TSTools: Organize Imports',
    },

    {
      '<leader>cR',
      '<CMD> TSToolsRemoveUnusedImports <CR>',
      mode = 'n',
      desc = 'TSTools: Remove Unused Imports',
    },

    {
      '<leader>cA',
      '<CMD> TSToolsFixAll <CR>',
      mode = 'n',
      desc = 'TSTools: Fix All Fixable Errors',
    },
  },

  opts = function()
    local nvim_lsp = require('lspconfig')

    return {
      root_dir = nvim_lsp.util.root_pattern('package.json'),
      single_file_support = false,
      settings = {
        separate_diagnostic_server = true,
        code_lens = 'off',
        complete_function_calls = true,
        tsserver_file_preferences = {
          importModuleSpecifierPreference = 'non-relative',
          includeCompletionsForModuleExports = true,
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = 'all',
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = true,
          quotePreference = 'auto',
        },
      },
    }
  end,
}
