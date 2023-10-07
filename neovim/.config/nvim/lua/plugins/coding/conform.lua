return {
  'stevearc/conform.nvim',

  event = 'VeryLazy',

  keys = {
    {
      '<leader>fm',
      '<CMD> Format <CR>',
      desc = 'Format Current Buffer',
    },
    {
      '<leader>fm',
      '<CMD> Format <CR>',
      desc = 'Format Current Selection',
      mode = 'v',
    },
  },

  config = function()
    require('conform').setup({
      formatters_by_ft = {
        -- Use a sub-list to run only the first available formatter
        ['javascript'] = { { 'prettierd', 'prettier' } },
        ['javascriptreact'] = { { 'prettierd', 'prettier' } },
        ['typescript'] = { { 'prettierd', 'prettier' } },
        ['typescriptreact'] = { { 'prettierd', 'prettier' } },
        ['vue'] = { { 'prettierd', 'prettier' } },
        ['css'] = { { 'prettierd', 'prettier' } },
        ['scss'] = { { 'prettierd', 'prettier' } },
        ['less'] = { { 'prettierd', 'prettier' } },
        ['html'] = { { 'prettierd', 'prettier' } },
        ['json'] = { { 'prettierd', 'prettier' } },
        ['jsonc'] = { { 'prettierd', 'prettier' } },
        ['yaml'] = { { 'prettierd', 'prettier' } },
        ['markdown'] = { { 'prettierd', 'prettier' } },
        ['markdown.mdx'] = { { 'prettierd', 'prettier' } },
        ['graphql'] = { { 'prettierd', 'prettier' } },
        ['handlebars'] = { { 'prettierd', 'prettier' } },
        ['lua'] = { 'stylua' },
        ['bash'] = { 'shfmt' },

        -- Use the "*" filetype to run formatters on all filetypes.
        ['*'] = {},

        -- Use the "_" filetype to run formatters on filetypes that don't
        -- have other formatters configured.
        ['_'] = { 'trim_whitespace' },
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
