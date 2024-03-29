return {
  'L3MON4D3/LuaSnip',

  dependencies = { 'rafamadriz/friendly-snippets' },

  config = function()
    local luasnip = require('luasnip')

    luasnip.config.set_config({
      history = true,
      updateevents = 'TextChanged,TextChangedI',
    })

    -- vscode format
    require('luasnip.loaders.from_vscode').lazy_load()
    require('luasnip.loaders.from_vscode').lazy_load({
      paths = vim.g.vscode_snippets_path or '',
    })

    -- snipmate format
    require('luasnip.loaders.from_snipmate').load()
    require('luasnip.loaders.from_snipmate').lazy_load({
      paths = vim.g.snipmate_snippets_path or '',
    })

    -- lua format
    require('luasnip.loaders.from_lua').load()
    require('luasnip.loaders.from_lua').lazy_load({
      paths = vim.g.lua_snippets_path or '',
    })

    require('luasnip').filetype_extend(
      'typescript',
      { 'javascript', 'javascriptreact', 'jsdoc' }
    )
  end,
}
