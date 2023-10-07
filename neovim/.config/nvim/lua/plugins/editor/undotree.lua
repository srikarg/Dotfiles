return {
  'mbbill/undotree',

  event = 'VeryLazy',

  keys = {
    {
      '<leader>u',
      '<CMD> UndotreeToggle<CR>',
      desc = 'Toggle [u]ndotree Plugin',
    },
  },

  init = function()
    vim.g.undotree_WindowLayout = 2
    vim.g.undotree_SplitWidth = 50
    vim.g.undotree_HighlightChangedWithSign = 1
    vim.g.undotree_HighlightSyntaxChange = 'DiffChange'
    vim.g.undotree_HighlightSyntaxAdd = 'DiffAdd'
    vim.g.undotree_HighlightSyntaxDel = 'DiffDelete'
  end,
}