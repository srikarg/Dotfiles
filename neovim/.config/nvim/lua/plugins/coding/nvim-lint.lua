return {
  'mfussenegger/nvim-lint',

  event = 'VeryLazy',

  keys = {
    {
      '<leader>l',
      function()
        require('lint').try_lint()
      end,
      desc = 'Lint Current Buffer',
    },
  },

  config = function()
    require('lint').linters_by_ft = {
      ['javascript'] = { 'eslint_d' },
      ['javascriptreact'] = { 'eslint_d' },
      ['typescript'] = { 'eslint_d' },
      ['typescriptreact'] = { 'eslint_d' },
      ['markdown'] = { 'markdownlint' },
      ['bash'] = { 'shellcheck' },
      ['dockerfile'] = { 'hadolint' },
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
