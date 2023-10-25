return {
  'nvim-neotest/neotest',

  keys = {
    {
      '[t',
      function()
        require('neotest').jump.prev({ status = 'failed' })
      end,
      desc = 'Testing: Jump to Previous Failing Test',
    },
    {
      ']t',
      function()
        require('neotest').jump.next({ status = 'failed' })
      end,
      desc = 'Testing: Jump to Next Failing Test',
    },
    {
      '<leader>tf',
      function()
        require('neotest').run.run(vim.fn.expand('%'))
      end,
      desc = 'Testing: Run Current File',
    },
    {
      '<leader>tn',
      function()
        require('neotest').run.run()
      end,
      desc = 'Testing: Run Nearest Test',
    },
    {
      '<leader>tt',
      function()
        require('neotest').run.run_last()
      end,
      desc = 'Testing: Run Last Test',
    },
    {
      '<leader>td',
      function()
        require('neotest').run.run({ strategy = 'dap' })
      end,
      desc = 'Testing: Debug Nearest Test',
    },
    {
      '<leader>ts',
      function()
        require('neotest').summary.toggle()
      end,
      desc = 'Testing: Toggle Summary View',
    },
    {
      '<leader>to',
      function()
        require('neotest').output.open({
          enter = true,
        })
      end,
      desc = 'Testing: Open Output',
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
      summary = {
        mappings = {
          expand = { 'e', '<2-LeftMouse>' },
          expand_all = 'E',
          jumpto = '<CR>',
        },
      },
      adapters = {
        require('neotest-jest')({
          jestCommand = 'npm test --',
          env = {
            CI = true,
          },
          cwd = function(path)
            return vim.fn.getcwd()
          end,
        }),
        require('neotest-vitest'),
      },
    })
  end,
}
