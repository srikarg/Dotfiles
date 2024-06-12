return {
  'nvim-neotest/neotest',

  dependencies = {
    'haydenmeade/neotest-jest',
    'marilari88/neotest-vitest',
  },

  opts = {
    summary = {
      mappings = {
        expand = { 'e', '<2-LeftMouse>' },
        expand_all = 'E',
        jumpto = '<CR>',
      },
    },
    adapters = {
      ['neotest-vitest'] = {},
      ['neotest-jest'] = {
        jestCommand = 'npm test --',
        env = {
          CI = true,
        },
        cwd = function()
          return vim.fn.getcwd()
        end,
      },
    },
  },
}
