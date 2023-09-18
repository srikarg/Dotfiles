local present, mini_ai = pcall(require, 'mini.ai')

if not present then
  return
end

mini_ai.setup({
  n_lines = 500,
  custom_textobjects = {
    o = mini_ai.gen_spec.treesitter({
      a = { '@block.outer', '@conditional.outer', '@loop.outer' },
      i = { '@block.inner', '@conditional.inner', '@loop.inner' },
    }),

    f = mini_ai.gen_spec.treesitter({
      a = '@function.outer',
      i = '@function.inner',
    }),

    c = mini_ai.gen_spec.treesitter({
      a = '@class.outer',
      i = '@class.inner',
    }),

    t = mini_ai.gen_spec.treesitter({
      a = '@comment.outer',
      i = '@comment.inner',
    }),

    e = function()
      local from = { line = 1, col = 1 }
      local to = {
        line = vim.fn.line('$'),
        col = math.max(vim.fn.getline('$'):len(), 1),
      }
      return { from = from, to = to }
    end,
  },
})
