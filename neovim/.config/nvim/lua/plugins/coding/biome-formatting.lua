return {
  {
    'williamboman/mason.nvim',

    opts = {
      ensure_installed = {
        'biome',
      },
    },
  },

  {
    'stevearc/conform.nvim',

    optional = true,

    opts = {
      formatters_by_ft = {
        -- Use a sub-list to run only the first available formatter
        ['javascript'] = { { 'biome', 'prettier' } },
        ['javascriptreact'] = { { 'biome', 'prettier' } },
        ['typescript'] = { { 'biome', 'prettier' } },
        ['typescriptreact'] = { { 'biome', 'prettier' } },
        ['json'] = { { 'biome', 'prettier' } },
        ['jsonc'] = { { 'biome', 'prettier' } },
      },

      formatters = {
        prettier = {
          condition = function(self, ctx)
            local deno_not_found =
              not vim.fs.find({ 'deno.json', 'deno.jsonc' }, { path = ctx.filename, upward = true })[1]

            local biome_not_found = not vim.fs.find({ 'biome.json' }, { path = ctx.filename, upward = true })[1]

            local is_biome_unformattable_filetype =
              vim.tbl_contains({ 'html', 'css', 'scss', 'yaml', 'markdown' }, vim.bo.filetype)

            -- Format with `prettier` only if `biome` and `deno_fmt` are both
            -- not in use in the current project OR if the editor is in a file
            -- that is not formattable by `biome`
            return (biome_not_found and deno_not_found) or is_biome_unformattable_filetype
          end,
        },

        biome = {
          cwd = require('conform.util').root_file({ 'biome.json' }),
          require_cwd = true,
        },
      },
    },
  },
}
