return {
  {
    'neovim/nvim-lspconfig',

    opts = function(_, opts)
      opts.inlay_hints = {
        enabled = false,
      }

      -- https://www.lazyvim.org/plugins/lsp#%EF%B8%8F-customizing-lsp-keymaps
      local keys = require('lazyvim.plugins.lsp.keymaps').get()

      keys[#keys + 1] = {
        '<S-CR>',
        function()
          if not vim.lsp.inline_completion.get() then
            return '<S-CR>'
          end
        end,
        mode = { 'i' },
        expr = true,
        desc = 'Accept the current inline completion',
      }

      return opts
    end,
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
