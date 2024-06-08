return {
  'nvim-telescope/telescope.nvim',

  dependencies = {
    'ray-x/telescope-ast-grep.nvim',
  },

  keys = {
    {
      '<leader>fA',
      '<CMD> Telescope AST_grep <CR>',
      desc = '[F]ind with [A]ST Grep',
    },
  },

  opts = {
    defaults = {
      vimgrep_arguments = {
        'rg',
        '-L',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
      },
      prompt_prefix = ' ',
      selection_caret = ' ',
      entry_prefix = '  ',
      initial_mode = 'insert',
      selection_strategy = 'reset',
      sorting_strategy = 'ascending',
      layout_strategy = 'flex',
      layout_config = {
        horizontal = {
          prompt_position = 'top',
          preview_width = 0.6,
        },
        vertical = {
          prompt_position = 'top',
        },
      },
      file_sorter = require('telescope.sorters').get_fuzzy_file,
      file_ignore_patterns = { '^node_modules/', '^.git/' },
      generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
      path_display = { 'filename_first' },
      winblend = 0,
      color_devicons = true,
      set_env = { ['COLORTERM'] = 'truecolor' },
      file_previewer = require('telescope.previewers').vim_buffer_cat.new,
      grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
      qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
      buffer_previewer_maker = require('telescope.previewers').buffer_previewer_maker,
      mappings = {
        i = {
          ['<C-t>'] = function(...)
            local trouble = require('trouble.sources.telescope')
            trouble.open(...)
          end,
        },
        n = {
          ['q'] = require('telescope.actions').close,

          ['<C-t>'] = function(...)
            local trouble = require('trouble.sources.telescope')
            trouble.open(...)
          end,
        },
      },
    },

    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = 'smart_case',
      },
    },
  },

  config = function(_, opts)
    local telescope = require('telescope')

    telescope.setup(opts)

    telescope.load_extension('fzf')
    telescope.load_extension('notify')
  end,
}
