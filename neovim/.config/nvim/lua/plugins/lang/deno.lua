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

    opts = {
      formatters_by_ft = {
        ['javascript'] = { 'biome', 'deno_fmt', 'prettier', stop_after_first = true },
        ['javascriptreact'] = { 'biome', 'deno_fmt', 'prettier', stop_after_first = true },
        ['typescript'] = { 'biome', 'deno_fmt', 'prettier', stop_after_first = true },
        ['typescriptreact'] = { 'biome', 'deno_fmt', 'prettier', stop_after_first = true },
        ['json'] = { 'biome', 'deno_fmt', 'prettier', stop_after_first = true },
        ['jsonc'] = { 'biome', 'deno_fmt', 'prettier', stop_after_first = true },
        ['markdown'] = { 'deno_fmt', 'prettier', stop_after_first = true },
        ['markdown.mdx'] = { 'deno_fmt', 'prettier', stop_after_first = true },
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
