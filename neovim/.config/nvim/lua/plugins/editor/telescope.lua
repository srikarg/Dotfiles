return {
  'nvim-telescope/telescope.nvim',

  version = false,

  cmd = 'Telescope',

  dependencies = {
    'nvim-lua/plenary.nvim',

    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },

    {
      'nvim-telescope/telescope-live-grep-args.nvim',
    },

    {
      'nvim-telescope/telescope-dap.nvim',

      dependencies = {
        'nvim-telescope/telescope.nvim',
        'nvim-treesitter/nvim-treesitter',
        'mfussenegger/nvim-dap',
      },

      config = true,
    },

    {
      'ray-x/telescope-ast-grep.nvim',

      dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim',
      },
    },
  },

  keys = {
    {
      '<leader>fa',
      '<CMD> Telescope find_files follow=true no_ignore=true hidden=true <CR>',
      desc = '[F]ind From [A]ll Files',
    },

    {
      '<leader>fA',
      '<CMD> Telescope AST_grep <CR>',
      desc = '[F]ind with [A]ST Grep',
    },

    {
      '<leader>fo',
      function()
        -- https://github.com/nvim-telescope/telescope.nvim/issues/2539#issuecomment-1562510095
        require('telescope.builtin').oldfiles({
          cwd_only = true,
          tiebreak = function(current_entry, existing_entry, _)
            return current_entry.index < existing_entry.index
          end,
        })
      end,
      desc = '[F]ind Recently [O]pened Files',
    },

    {
      '<leader>fb',
      function()
        require('telescope.builtin').buffers({
          sort_mru = true,
        })
      end,
      desc = '[F]ind Existing [B]uffers',
    },

    {
      '<leader>fk',
      function()
        require('telescope.builtin').keymaps()
      end,
      desc = '[F]ind [K]eymaps',
    },

    {
      '<leader>fc',
      '<CMD> Telescope current_buffer_fuzzy_find <CR>',
      desc = '[F]ind In [C]urrent Buffer',
    },

    {
      '<leader>ff',
      function()
        if vim.loop.fs_stat(vim.loop.cwd() .. '/.git') then
          require('telescope.builtin').git_files({
            show_untracked = true,
          })
        else
          require('telescope.builtin').find_files()
        end
      end,
      desc = '[F]ind [F]iles',
    },

    {
      '<leader>fh',
      '<CMD> Telescope help_tags <CR>',
      desc = '[F]ind [H]elp',
    },

    {
      '<leader>fH',
      '<CMD> Telescope highlights <CR>',
      desc = '[F]ind [H]ighlights',
    },

    {
      '<leader>fw',
      function()
        require('telescope-live-grep-args.shortcuts').grep_word_under_cursor()
      end,
      desc = '[F]ind Current [W]ord',
    },

    {
      '<leader>fr',
      function()
        require('telescope').extensions.live_grep_args.live_grep_args()
      end,
      desc = '[F]ind With [G]rep',
    },

    {
      '<leader>fd',
      '<CMD> Telescope diagnostics <CR>',
      desc = '[F]ind [D]iagnostics',
    },

    {
      '<leader>f/',
      '<CMD> Telescope resume <CR>',
      desc = '[F]ind Resume',
    },

    {
      '<leader>gc',
      '<CMD> Telescope git_commits <CR>',
      desc = '[G]it [C]ommits',
    },

    {
      '<leader>gb',
      '<CMD> Telescope git_branches <CR>',
      desc = '[G]it [B]ranches',
    },

    {
      '<leader>gs',
      '<CMD> Telescope git_status <CR>',
      desc = '[G]it [S]tatus',
    },

    {
      '<leader>fr',
      function()
        require('telescope-live-grep-args.shortcuts').grep_visual_selection()
      end,
      desc = '[F]ind With [G]rep',
      mode = 'v',
    },
  },

  config = function()
    require('telescope').setup({
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
              local trouble = require('trouble.providers.telescope')
              trouble.open_with_trouble(...)
            end,
          },
          n = {
            ['q'] = require('telescope.actions').close,

            ['<C-t>'] = function(...)
              local trouble = require('trouble.providers.telescope')
              trouble.open_with_trouble(...)
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

        live_grep_args = {
          auto_quoting = true,
          mappings = {
            i = {
              ['<C-k>'] = function(...)
                require('telescope-live-grep-args.actions').quote_prompt()(...)
              end,
              ['<C-i>'] = function(...)
                require('telescope-live-grep-args.actions').quote_prompt({
                  postfix = ' --iglob ',
                })(...)
              end,
              ['<C-a>'] = function(...)
                require('telescope-live-grep-args.actions').quote_prompt({
                  postfix = ' --hidden --no-ignore',
                })(...)
              end,
            },
          },
        },
      },
    })

    require('telescope').load_extension('fzf')
    require('telescope').load_extension('live_grep_args')
    require('telescope').load_extension('notify')
    require('telescope').load_extension('dap')
  end,
}
