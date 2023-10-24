return {
  'nvim-neotest/neotest',

  keys = {
    {
      '<leader>tf',
      ':lua require("neotest").run.run(vim.fn.expand("%"))<CR>',
      desc = 'Testing: Run Current File',
    },
    {
      '<leader>tn',
      ':lua require("neotest").run.run()<CR>',
      desc = 'Testing: Run Nearest Test',
    },
    {
      '<leader>tt',
      ':lua require("neotest").run.run_last()<CR>',
      desc = 'Testing: Run Last Test',
    },
    {
      '<leader>td',
      ':lua require("neotest").run.run({strategy = "dap"})<CR>',
      desc = 'Testing: Debug Nearest Test',
    },
  },

  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'antoinemadec/FixCursorHold.nvim',
    'haydenmeade/neotest-jest',
    'marilari88/neotest-vitest',
  },

  config = function()
    require('neotest').setup({
      adapters = {
        require('neotest-jest')({
          jestCommand = 'npm test --',
          env = { CI = true },
          cwd = function(path)
            return vim.fn.getcwd()
          end,
        }),
        require('neotest-vitest'),
      },
    })
  end,
}
