local function load_cb()
  if vim.g.show_coverage then
    require('coverage').show()
  else
    require('coverage').hide()
  end
end

return {
  'andythigpen/nvim-coverage',

  lazy = false,

  dependencies = { 'nvim-lua/plenary.nvim' },

  keys = {
    { '<leader>tC', '<CMD> CoverageLoad <CR> <CMD> CoverageSummary <CR>', desc = 'Coverage Summary' },
  },

  opts = function()
    Snacks.toggle
      .new({
        name = 'Toggle Coverage in Gutter',
        get = function()
          return vim.g.show_coverage
        end,
        set = function(state)
          vim.g.show_coverage = state
          require('coverage').load(state)
        end,
      })
      :map('<leader>tc', { desc = 'Toggle Coverage in Gutter' })

    return {
      auto_reload = true,
      load_coverage_cb = load_cb,
    }
  end,
}
