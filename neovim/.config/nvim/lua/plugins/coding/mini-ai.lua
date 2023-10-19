return {
  'echasnovski/mini.ai',

  event = 'VeryLazy',

  opts = function()
    local ai = require('mini.ai')

    return {
      n_lines = 500,
      custom_textobjects = {
        o = ai.gen_spec.treesitter({
          a = { '@block.outer', '@conditional.outer', '@loop.outer' },
          i = { '@block.inner', '@conditional.inner', '@loop.inner' },
        }),

        f = ai.gen_spec.treesitter({
          a = '@function.outer',
          i = '@function.inner',
        }),

        c = ai.gen_spec.treesitter({
          a = { '@class.outer', '@comment.outer' },
          i = { '@class.inner', '@comment.inner' },
        }),

        ['='] = ai.gen_spec.treesitter({
          a = '@assignment.outer',
          i = '@assignment.inner',
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
    }
  end,

  config = function(_, opts)
    require('mini.ai').setup(opts)

    local i = {
      [' '] = 'Whitespace',
      ['='] = 'Assignment',
      ['"'] = 'Balanced "',
      ["'"] = "Balanced '",
      ['`'] = 'Balanced `',
      ['('] = 'Balanced (',
      [')'] = 'Balanced ) including white-space',
      ['>'] = 'Balanced > including white-space',
      ['<lt>'] = 'Balanced <',
      [']'] = 'Balanced ] including white-space',
      ['['] = 'Balanced [',
      ['}'] = 'Balanced } including white-space',
      ['{'] = 'Balanced {',
      ['?'] = 'User Prompt',
      _ = 'Underscore',
      a = 'Argument',
      b = 'Balanced ), ], }',
      c = 'Class, Comment',
      f = 'Function',
      o = 'Block, Conditional, Loop',
      e = 'Entire Buffer',
      q = 'Quote `, ", \'',
      t = 'Tag',
    }
    local a = vim.deepcopy(i)
    for k, v in pairs(a) do
      a[k] = v:gsub(' including.*', '')
    end

    local ic = vim.deepcopy(i)
    local ac = vim.deepcopy(a)
    for key, name in pairs({ n = 'Next', l = 'Last' }) do
      i[key] = vim.tbl_extend(
        'force',
        { name = 'Inside ' .. name .. ' textobject' },
        ic
      )
      a[key] = vim.tbl_extend(
        'force',
        { name = 'Around ' .. name .. ' textobject' },
        ac
      )
    end

    require('which-key').register({
      mode = { 'o', 'x' },
      i = i,
      a = a,
    })
  end,
}
