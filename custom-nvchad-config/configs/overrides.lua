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

-- Sourced from https://github.com/BrunoKrugel/dotfiles/blob/master/configs/cmp.lua#L34-L65
local function limit_lsp_types(entry, ctx)
  local kind = entry:get_kind()
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

  if kind == require('cmp').lsp.CompletionItemKind.Text then
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

return M
