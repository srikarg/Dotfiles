return {
  'mfussenegger/nvim-lint',

  event = 'VeryLazy',

  keys = {
    {
      '<leader>L',
      function()
        require('lint').try_lint()
      end,
      desc = 'Lint Current Buffer',
    },
  },

  config = function()
    require('lint').linters_by_ft = {
      ['markdown'] = { 'markdownlint' },
      ['bash'] = { 'shellcheck' },
      ['dockerfile'] = { 'hadolint' },
      ['dotenv'] = { 'dotenv_linter' },
      ['zsh'] = { 'zsh' },
    }

    local diagnostics_active = true

    vim.keymap.set('n', '<leader>ud', function()
      diagnostics_active = not diagnostics_active
      print(
        'Setting diagnostic visibility to: ' .. tostring(diagnostics_active)
      )
      if diagnostics_active then
        vim.diagnostic.show()
      else
        vim.diagnostic.hide()
      end
    end, { desc = 'Toggle [D]iagnostic Visibility' })

    vim.api.nvim_create_autocmd(
      { 'BufWritePost', 'BufReadPost', 'InsertLeave' },
      {
        group = vim.api.nvim_create_augroup('nvim-lint', { clear = true }),
        callback = function()
          if diagnostics_active then
            require('lint').try_lint()
          end
        end,
      }
    )
  end,
}
