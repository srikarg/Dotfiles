---@module "leetcode.nvim"
local leet_arg = 'leetcode.nvim'

return {
  'kawre/leetcode.nvim',

  build = ':TSUpdate html',

  lazy = leet_arg ~= vim.fn.argv(0, -1),

  cmd = 'Leet',

  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'nvim-treesitter/nvim-treesitter',
  },

  opts = {
    ---@type string
    arg = leet_arg,

    ---@type lc.lang
    lang = 'python3',

    ---@type lc.picker
    picker = { provider = 'snacks-picker' },
  },
}
