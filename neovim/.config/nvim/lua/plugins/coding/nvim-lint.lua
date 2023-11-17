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

    vim.api.nvim_create_autocmd(
      { 'BufWritePost', 'BufReadPost', 'InsertLeave' },
      {
        group = vim.api.nvim_create_augroup('nvim-lint', { clear = true }),
        callback = function()
          require('lint').try_lint()
        end,
      }
    )
  end,
}
