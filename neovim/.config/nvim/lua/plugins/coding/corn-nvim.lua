return {
  'RaafatTurki/corn.nvim',

  dependencies = { 'neovim/nvim-lspconfig' },

  event = 'VeryLazy',

  opts = function()
    local diagnosticIcons = require('config').icons.diagnostics

    return {
      -- A preprocessor function that could be used for truncation or other purposes
      item_preprocess_func = function(item)
        return item
      end,

      -- If this plugin is disabled, enable virtual text diagnostics. Otherwise,
      -- disable virtual text diagnostics as we will display them in the corner
      -- instead via this plugin.
      on_toggle = function(is_hidden)
        if is_hidden then
          vim.diagnostic.config({ virtual_text = false })
        else
          vim.diagnostic.config({
            virtual_text = {
              spacing = 4,
              source = 'if_many',
              prefix = function(diagnostic)
                for name, icon in pairs(diagnosticIcons) do
                  if
                    diagnostic.severity == vim.diagnostic.severity[name:upper()]
                  then
                    return icon
                  end
                end
              end,
            },
          })
        end
      end,

      icons = {
        error = diagnosticIcons.Error,
        warn = diagnosticIcons.Warn,
        hint = diagnosticIcons.Hint,
        info = diagnosticIcons.Info,
      },

      blacklisted_modes = { 'i' },
    }
  end,
}
