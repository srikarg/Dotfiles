return {
  'stevearc/conform.nvim',

  event = 'VeryLazy',

  keys = {
    {
      '<leader>F',
      '<CMD> Format <CR>',
      desc = 'Format Current Buffer',
    },
    {
      '<leader>F',
      '<CMD> Format <CR>',
      desc = 'Format Current Selection',
      mode = 'v',
    },
    {
      '<leader>uf',
      '<CMD> FormatToggle <CR>',
      desc = 'Toggle [F]ormatting',
    },
  },

  config = function()
    local conform_utils = require('conform.util')

    require('conform').setup({
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
        ['clojure'] = { 'joker' },
        ['xml'] = { 'xmlformat' },

        -- Use the "_" filetype to run formatters on filetypes that don't
        -- have other formatters configured.
      },

      formatters = {
        prettier = {
          condition = function(self, ctx)
            local deno_not_found = not vim.fs.find(
              { 'deno.json', 'deno.jsonc' },
              { path = ctx.filename, upward = true }
            )[1]

            local biome_not_found = not vim.fs.find(
              { 'biome.json' },
              { path = ctx.filename, upward = true }
            )[1]

            local is_biome_unformattable_filetype = vim.tbl_contains(
              { 'html', 'css', 'scss', 'yaml', 'markdown' },
              vim.bo.filetype
            )

            -- Format with `prettier` only if `biome` and `deno_fmt` are both
            -- not in use in the current project OR if the editor is in a file
            -- that is not formattable by `biome`
            return (biome_not_found and deno_not_found)
              or is_biome_unformattable_filetype
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
    })

    -- Switch for controlling whether you want autoformatting.
    local format_is_enabled = true
    vim.api.nvim_create_user_command('FormatToggle', function()
      format_is_enabled = not format_is_enabled
      print('Setting autoformatting to: ' .. tostring(format_is_enabled))
    end, {})

    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = '*',
      callback = function(args)
        if not format_is_enabled then
          return
        end
        require('conform').format({
          bufnr = args.buf,
          lsp_fallback = true,
        })
      end,
    })

    vim.api.nvim_create_user_command('Format', function(args)
      require('conform').format({
        bufnr = args.buf,
        lsp_fallback = true,
      })
    end, { desc = 'Format with Conform Plugin' })
  end,
}
