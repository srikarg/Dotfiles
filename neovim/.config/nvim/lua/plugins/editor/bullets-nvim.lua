return {
  'bullets-vim/bullets.nvim',

  ft = {
    'markdown',
    'text',
    'gitcommit',
    'scratch',
  },

  ---@module 'bullets'
  ---@type bullets.Config
  opts = {
    enabled_file_types = {
      'markdown',
      'text',
      'gitcommit',
      'scratch',
    },
    outline_levels = {
      'num',
      'std-',
    },

    mapping_leader = '',
  },
}
