local M = {}

M.treesitter = {
  ensure_installed = {
    'vim',
    'lua',
    'html',
    'css',
    'javascript',
    'typescript',
    'tsx',
    'json',
    'jsdoc',
    'markdown',
    'markdown_inline',
    'bash',
  },

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
      keymaps = {
        ['ia'] = '@parameter.inner',
        ['aa'] = '@parameter.outer',
      },
      include_surrounding_whitespace = true,
    },
    move = {
      enable = true,
      goto_next_start = {
        [']m'] = '@function.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
      },
    },
  },

  textsubjects = {
    enable = true,
    prev_selection = ',',
    keymaps = {
      ['.'] = 'textsubjects-smart',
      [';'] = 'textsubjects-container-outer',
      ['i;'] = 'textsubjects-container-inner',
    },
  },
}

M.mason = {
  ensure_installed = {
    -- Lua
    'lua-language-server',
    'stylua',

    -- Web Development
    'css-lsp',
    'html-lsp',
    'typescript-language-server',
    'deno',
    'prettier',
    'eslint-lsp',
    'emmet-language-server',
    'json-lsp',
    'yaml-language-server',

    -- Markdown
    'markdownlint',
    'marksman',

    -- Docker
    'docker-compose-language-service',

    -- Shell
    'shfmt',
    'shellcheck',
    'bash-language-server',
  },
}

-- git support in nvimtree
M.nvimtree = {
  filters = {
    dotfiles = false,
    git_ignored = false,
    git_clean = false,
  },

  git = {
    enable = true,
  },

  actions = {
    expand_all = {
      exclude = { '.git', 'node_modules' },
    },
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

M.telescope = {
  defaults = {
    prompt_prefix = '❯ ',
    selection_caret = '❯ ',
    vimgrep_arguments = {
      'rg',
      '-L',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--hidden',
      '--no-ignore',
    },
    file_ignore_patterns = { 'node_modules/', '.git/' },
  },
}

M.cmp = {
  experimental = { ghost_text = true },

  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'nvim_lua' },
    { name = 'path' },
  },
}

return M
