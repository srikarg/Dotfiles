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
    'markdown',
    'markdown_inline',
    'bash',
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
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
    'markdownlint',
    'eslint-lsp',
    'emmet-language-server',
    'json-lsp',

    -- Docker
    'docker-compose-language-service',

    -- Shell
    'shfmt',
    'shellcheck',
    'bash-language-server',

    -- General
    'codespell',
  },
}

-- git support in nvimtree
M.nvimtree = {
  filters = {
    dotfiles = true,
  },

  git = {
    enable = true,
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
    },
    file_ignore_patterns = { 'node_modules', '.git' },
  },
}

return M
