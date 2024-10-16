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
    return kind == types.lsp.CompletionItemKind.Method
      or kind == types.lsp.CompletionItemKind.Field
      or kind == types.lsp.CompletionItemKind.Property
  elseif string.match(line, '^%s+%w+$') then
    return kind == types.lsp.CompletionItemKind.Function or kind == types.lsp.CompletionItemKind.Variable
  end

  if kind == types.lsp.CompletionItemKind.Text and completionItem.detail ~= 'Emmet Abbreviation' then
    return false
  end

  return true
end

return {
  'iguanacucumber/magazine.nvim',

  name = 'nvim-cmp',

  dependencies = {
    -- Snippet Engine & its associated nvim-cmp source
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',

    -- Adds LSP completion capabilities
    'hrsh7th/cmp-nvim-lsp',

    -- Adds completion of neovim's Lua runtime API
    'hrsh7th/cmp-nvim-lua',

    -- Adds completion of buffer words
    'hrsh7th/cmp-buffer',

    -- Adds completion of paths
    'hrsh7th/cmp-path',

    -- Adds completion of calculations
    'hrsh7th/cmp-calc',

    -- Adds completion of LSP signature
    'hrsh7th/cmp-nvim-lsp-signature-help',

    -- Adds completion of document symbols
    'hrsh7th/cmp-nvim-lsp-document-symbol',

    -- Command line history completion
    'dmitmel/cmp-cmdline-history',

    -- Adds completion of Tailwind CSS colors
    'roobert/tailwindcss-colorizer-cmp.nvim',

    'hrsh7th/cmp-cmdline',

    -- Adds a number of user-friendly snippets
    'rafamadriz/friendly-snippets',
  },

  opts = function(_, opts)
    local cmp = require('cmp')
    local luasnip = require('luasnip')

    opts.experimental = vim.tbl_extend('force', opts.experimental, {
      ghost_text = {
        hl_group = 'Comment',
      },
    })

    opts.mapping = vim.tbl_extend('force', opts.mapping, {
      ['<C-n>'] = cmp.mapping.select_next_item({
        behavior = cmp.SelectBehavior.Insert,
      }),
      ['<C-p>'] = cmp.mapping.select_prev_item({
        behavior = cmp.SelectBehavior.Insert,
      }),
      ['<C-u>'] = cmp.mapping.scroll_docs(-4),
      ['<C-d>'] = cmp.mapping.scroll_docs(4),
      ['<C-l>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }),
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { 'i', 's', 'c' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's', 'c' }),
    })

    table.insert(opts.sources, {
      name = 'nvim_lsp',
      keyword_length = 2,
      entry_filter = limit_lsp_types,
    })

    table.insert(opts.sources, { name = 'codeium' })
    table.insert(opts.sources, { name = 'copilot' })
    table.insert(opts.sources, { name = 'nvim_lsp_signature_help' })
    table.insert(opts.sources, { name = 'luasnip', max_item_count = 3 })
    table.insert(opts.sources, { name = 'buffer', keyword_length = 5 })
    table.insert(opts.sources, { name = 'nvim_lua' })
    table.insert(opts.sources, { name = 'path' })
    table.insert(opts.sources, { name = 'calc' })

    opts.sorting = vim.tbl_extend('force', opts.sorting, {
      comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,
        cmp.config.compare.recently_used,

        function(entry1, entry2)
          local _, entry1_under = entry1.completion_item.label:find('^_+')
          local _, entry2_under = entry2.completion_item.label:find('^_+')
          entry1_under = entry1_under or 0
          entry2_under = entry2_under or 0
          if entry1_under > entry2_under then
            return false
          elseif entry1_under < entry2_under then
            return true
          end
        end,

        cmp.config.compare.kind,
        cmp.config.compare.locality,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    })

    opts.performance = vim.tbl_extend('force', opts.performance or {}, {
      debounce = 30,
      throttle = 20,
      async_budget = 0.8,
      max_view_entries = 20,
      fetching_timeout = 250,
    })

    opts.matching = vim.tbl_extend('force', opts.matching or {}, {
      disallow_fuzzy_matching = false,
      disallow_fullfuzzy_matching = false,
      disallow_partial_fuzzy_matching = false,
      disallow_partial_matching = false,
      disallow_prefix_unmatching = false,
      disallow_symbol_nonprefix_matching = true,
    })

    opts.view = vim.tbl_extend('force', opts.view or {}, {
      entries = {
        follow_cursor = true,
      },
    })

    -- `/` cmdline setup.
    cmp.setup.cmdline('/', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        {
          name = 'nvim_lsp_document_symbol',
        },
      }, {
        {
          name = 'buffer',
        },
      }),
    })

    -- `:` cmdline setup.
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        {
          name = 'path',
        },
      }, {
        {
          name = 'cmdline',
        },
      }, {
        {
          name = 'cmdline_history',
        },
      }),
    })
  end,
}
