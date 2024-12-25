local leet_arg = 'leetcode.nvim'

return {
  'kawre/leetcode.nvim',

  build = ':TSUpdate html',

  lazy = leet_arg ~= vim.fn.argv(0, -1),

  cmd = 'Leet',

  dependencies = {
    'ibhagwan/fzf-lua',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'nvim-treesitter/nvim-treesitter',
  },

  opts = {
    arg = leet_arg,
    lang = 'python3',
  },
}
