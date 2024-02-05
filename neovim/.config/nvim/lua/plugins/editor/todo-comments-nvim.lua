-- Finds and lists all of the TODO, HACK, BUG, etc comment
-- in your project and loads them into a browsable list.
--
return {
  'folke/todo-comments.nvim',

  cmd = { 'TodoTrouble', 'TodoTelescope' },

  event = 'VeryLazy',

  config = true,

  keys = {
    {
      '<leader>xt',
      '<cmd>TodoTrouble<cr>',
      desc = 'Todo (Trouble)',
    },

    {
      '<leader>xT',
      '<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>',
      desc = 'Todo/Fix/Fixme (Trouble)',
    },

    {
      '<leader>ft',
      '<cmd>TodoTelescope<cr>',
      desc = 'Todo',
    },

    {
      '<leader>fT',
      '<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>',
      desc = 'Todo/Fix/Fixme',
    },
  },
}
