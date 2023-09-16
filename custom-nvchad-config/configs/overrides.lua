local M = {}

M.devicons = {
  override_by_filename = {
    ['astro'] = {
      icon = '',
      color = '#FFFFFF',
      name = 'Astro',
    },
  },
}

M.treesitter = {
  ensure_installed = {
    -- Miscellaneous
    'vim',
    'vimdoc',
    'lua',
    'regex',
    'dockerfile',
    'mermaid',
    'python',

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
    'yaml',
    'jsdoc',

    -- Markdown
    'markdown',
    'markdown_inline',

    -- Shell
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

        ['if'] = '@function.inner',
        ['af'] = '@function.outer',

        ['it'] = '@comment.inner',
        ['at'] = '@comment.outer',
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
    'tailwindcss-language-server',
    'html-lsp',
    'typescript-language-server',
    'astro-language-server',
    'svelte-language-server',
    'js-debug-adapter',
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
    },
    file_ignore_patterns = { '^node_modules/', '^.git/' },
  },

  extensions_list = { 'themes', 'terms', 'fzf', 'live_grep_args', 'dap' },

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
          ['<C-t>'] = function(...)
            require('telescope-live-grep-args.actions').quote_prompt({
              postfix = ' -t',
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
}

-- Sourced from https://github.com/BrunoKrugel/dotfiles/blob/master/configs/cmp.lua#L34-L65
local function limit_lsp_types(entry, ctx)
  local kind = entry:get_kind()
  local completionItem = entry:get_completion_item()
  local line = ctx.cursor.line
  local col = ctx.cursor.col
  local char_before_cursor = string.sub(line, col - 1, col - 1)
  local char_after_dot = string.sub(line, col, col)
  local types = require('cmp.types')

  if char_before_cursor == '.' and char_after_dot:match('[a-zA-Z]') then
    if
      kind == types.lsp.CompletionItemKind.Method
      or kind == types.lsp.CompletionItemKind.Field
      or kind == types.lsp.CompletionItemKind.Property
    then
      return true
    else
      return false
    end
  elseif string.match(line, '^%s+%w+$') then
    if
      kind == types.lsp.CompletionItemKind.Function
      or kind == types.lsp.CompletionItemKind.Variable
    then
      return true
    else
      return false
    end
  end

  if
    kind == types.lsp.CompletionItemKind.Text
    and completionItem.detail ~= 'Emmet Abbreviation'
  then
    return false
  end

  return true
end

M.cmp = {
  experimental = { ghost_text = true },

  sources = {
    { name = 'nvim_lsp', keyword_length = 5, entry_filter = limit_lsp_types },
    { name = 'nvim_lsp_signature_help' },
    { name = 'luasnip', max_item_count = 3 },
    { name = 'buffer', keyword_length = 5 },
    { name = 'nvim_lua' },
    { name = 'path' },
    { name = 'calc' },
  },

  performance = {
    debounce = 300,
    throttle = 60,
    max_view_entries = 10,
    fetching_timeout = 200,
  },
}

M.blankline = {
  use_treesitter = true,
  use_treesitter_scope = true,

  show_current_context = true,
  show_current_context_start = true,
}

M.colorizer = {
  filetypes = {
    '*',
    cmp_docs = { always_update = true },
    cmp_menu = { always_update = true },
  },
  user_default_options = {
    names = false,
    RRGGBBAA = true,
    rgb_fn = true,
    tailwind = true,
    RGB = true,
    RRGGBB = true,
    AARRGGBB = true,
    hsl_fn = true,
    css = true,
    css_fn = true,
    mode = 'background',
    sass = { enable = true, parsers = { 'css' } },
    virtualtext = '■',
    always_update = true,
  },
}

return M
