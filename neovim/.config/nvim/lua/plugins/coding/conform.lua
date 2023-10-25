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
    {
      '<leader>uf',
      '<CMD> FormatToggle <CR>',
      desc = 'Toggle [F]ormatting',
    },
  },

  config = function()
    require('conform').setup({
      formatters_by_ft = {
        -- Use the "*" filetype to run formatters on all filetypes.
        ['*'] = { 'trim_whitespace', 'trim_newlines' },

        -- Use a sub-list to run only the first available formatter
        ['javascript'] = { 'prettier' },
        ['javascriptreact'] = { 'prettier' },
        ['typescript'] = { 'prettier' },
        ['typescriptreact'] = { 'prettier' },
        ['vue'] = { 'prettier' },
        ['css'] = { 'prettier' },
        ['scss'] = { 'prettier' },
        ['less'] = { 'prettier' },
        ['html'] = { 'prettier' },
        ['json'] = { 'prettier' },
        ['jsonc'] = { 'prettier' },
        ['yaml'] = { 'prettier' },
        ['markdown'] = { 'prettier' },
        ['markdown.mdx'] = { 'prettier' },
        ['graphql'] = { 'prettier' },
        ['handlebars'] = { 'prettier' },
        ['lua'] = { 'stylua' },
        ['bash'] = { 'shfmt' },

        -- Use the "_" filetype to run formatters on filetypes that don't
        -- have other formatters configured.
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
