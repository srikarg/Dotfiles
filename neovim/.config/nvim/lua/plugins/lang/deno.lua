return {
  {
    'neovim/nvim-lspconfig',

    opts = {
      servers = {
        denols = {
          root_dir = require('lspconfig').util.root_pattern('deno.json', 'deno.jsonc'),

          settings = {
            deno = {
              enable = true,
              lint = true,
              unstable = true,
              suggest = {
                imports = {
                  autoDiscover = true,
                  hosts = {
                    ['https://deno.land'] = true,
                  },
                },
              },
            },
          },
        },
      },
    },
  },

  {
    'williamboman/mason.nvim',

    opts = {
      ensure_installed = {
        'deno',
      },
    },
  },

  {
    'stevearc/conform.nvim',

    optional = true,

    opts = {
      formatters_by_ft = {
        ['javascript'] = { { 'biome', 'deno_fmt', 'prettier' } },
        ['javascriptreact'] = { { 'biome', 'deno_fmt', 'prettier' } },
        ['typescript'] = { { 'biome', 'deno_fmt', 'prettier' } },
        ['typescriptreact'] = { { 'biome', 'deno_fmt', 'prettier' } },
        ['json'] = { { 'biome', 'deno_fmt', 'prettier' } },
        ['jsonc'] = { { 'biome', 'deno_fmt', 'prettier' } },
        ['markdown'] = { { 'deno_fmt', 'prettier' } },
        ['markdown.mdx'] = { { 'deno_fmt', 'prettier' } },
      },

      formatters = {
        deno_fmt = {
          cwd = require('conform.util').root_file({ 'deno.json', 'deno.jsonc' }),
          require_cwd = true,
        },
      },
    },
  },

  {
    'nvim-neotest/neotest',

    dependencies = {
      'MarkEmmons/neotest-deno',
    },

    opts = {
      adapters = {
        ['neotest-deno'] = {},
      },
    },
  },
}
