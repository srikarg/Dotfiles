return {
  -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',

  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'windwp/nvim-ts-autotag',
  },

  build = ':TSUpdate',

  config = function()
    require('nvim-treesitter.configs').setup({
      -- https://github.com/windwp/nvim-ts-autotag
      autotag = {
        enable = true,
      },

      -- Add languages to be installed here that you want installed for treesitter
      ensure_installed = {
        -- Miscellaneous
        'vim',
        'vimdoc',
        'lua',
        'regex',
        'dockerfile',
        'mermaid',
        'python',
        'clojure',

        -- Git
        'gitignore',
        'diff',
        'gitcommit',
        'git_rebase',
        'git_config',

        -- Web Development
        'astro',
        'svelte',
        'html',
        'css',
        'scss',
        'javascript',
        'typescript',
        'tsx',
        'json',
        'json5',
        'jsonc',
        'yaml',
        'jsdoc',

        -- Markdown
        'markdown',
        'markdown_inline',

        -- Shell
        'bash',
      },

      -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
      auto_install = false,

      highlight = {
        enable = true,
        use_languagetree = true,
      },

      indent = {
        enable = true,
      },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<CR>',
          scope_incremental = '<CR>',
          node_incremental = '<TAB>',
          node_decremental = '<S-TAB>',
        },
      },

      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          include_surrounding_whitespace = true,
        },

        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            [']f'] = '@function.outer',
            [']c'] = '@class.outer',
          },
          goto_next_end = {
            [']F'] = '@function.outer',
            [']C'] = '@class.outer',
          },
          goto_previous_start = {
            ['[f'] = '@function.outer',
            ['[c'] = '@class.outer',
          },
          goto_previous_end = {
            ['[F'] = '@function.outer',
            ['[C'] = '@class.outer',
          },
        },

        swap = {
          enable = true,
          swap_next = {
            ['<leader>a'] = '@parameter.inner',
          },
          swap_previous = {
            ['<leader>A'] = '@parameter.inner',
          },
        },
      },
    })

    vim.treesitter.language.register('bash', 'dotenv')
  end,
}
