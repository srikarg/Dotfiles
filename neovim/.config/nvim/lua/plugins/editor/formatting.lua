local supported = {
  'javascript',
  'javascriptreact',
  'typescript',
  'typescriptreact',
  'json',
  'jsonc',
  'json5',
  'css',
  'scss',
  'html',
  'vue',
  'svelte',
  'yaml',
  'markdown',
  'graphql',
  'toml',
  'less',
}

return {
  {
    'mason-org/mason.nvim',

    opts = {
      ensure_installed = {
        'oxfmt',
      },
    },
  },

  {
    'stevearc/conform.nvim',

    optional = true,

    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}

      for _, ft in ipairs(supported) do
        opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
        table.insert(opts.formatters_by_ft[ft], 'oxfmt')
      end
    end,
  },
}
