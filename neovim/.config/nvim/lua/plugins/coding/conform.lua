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
        ['javascript'] = { { 'deno_fmt', 'prettier' } },
        ['javascriptreact'] = { { 'deno_fmt', 'prettier' } },
        ['typescript'] = { { 'deno_fmt', 'prettier' } },
        ['typescriptreact'] = { { 'deno_fmt', 'prettier' } },
        ['vue'] = { 'prettier' },
        ['css'] = { 'prettier' },
        ['scss'] = { 'prettier' },
        ['less'] = { 'prettier' },
        ['html'] = { 'prettier' },
        ['json'] = { { 'deno_fmt', 'prettier' } },
        ['jsonc'] = { { 'deno_fmt', 'prettier' } },
        ['yaml'] = { 'prettier' },
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
            -- Don't format with `prettier` if we're in a deno project as we can
            -- just use `denofmt` instead
            return not vim.fs.find(
              { 'deno.json', 'deno.jsonc' },
              { path = ctx.filename, upward = true }
            )[1]
          end,
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
