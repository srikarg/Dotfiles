return {
  'stevearc/conform.nvim',

  opts = function()
    local conform_utils = require('conform.util')

    return {
      formatters_by_ft = {
        -- Use the "*" filetype to run formatters on all filetypes.
        ['*'] = { 'trim_whitespace', 'trim_newlines' },

        -- Use a sub-list to run only the first available formatter
        ['javascript'] = { { 'biome', 'deno_fmt', 'prettier' } },
        ['javascriptreact'] = { { 'biome', 'deno_fmt', 'prettier' } },
        ['typescript'] = { { 'biome', 'deno_fmt', 'prettier' } },
        ['typescriptreact'] = { { 'biome', 'deno_fmt', 'prettier' } },
        ['vue'] = { 'prettier' },
        ['css'] = { 'prettier' },
        ['scss'] = { 'prettier' },
        ['less'] = { 'prettier' },
        ['html'] = { 'prettier' },
        ['json'] = { { 'biome', 'deno_fmt', 'prettier' } },
        ['jsonc'] = { { 'biome', 'deno_fmt', 'prettier' } },
        ['yaml'] = { 'prettier' },
        ['go'] = { 'goimports', 'gofumpt' },
        ['markdown'] = { { 'deno_fmt', 'prettier' } },
        ['markdown.mdx'] = { { 'deno_fmt', 'prettier' } },
        ['graphql'] = { 'prettier' },
        ['handlebars'] = { 'prettier' },
        ['lua'] = { 'stylua' },
        ['bash'] = { 'shfmt' },
        ['sh'] = { 'shfmt' },

        -- Use the "_" filetype to run formatters on filetypes that don't
        -- have other formatters configured.
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
          cwd = conform_utils.root_file({ 'biome.json' }),
          require_cwd = true,
        },

        deno_fmt = {
          cwd = conform_utils.root_file({ 'deno.json', 'deno.jsonc' }),
          require_cwd = true,
        },
      },
    }
  end,
}
