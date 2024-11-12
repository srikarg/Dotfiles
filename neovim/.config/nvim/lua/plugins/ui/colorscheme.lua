return {
  {
    'folke/tokyonight.nvim',

    opts = {
      on_highlights = function(highlights, colors)
        highlights.DiagnosticUnnecessary = { fg = colors.comment }

        highlights.CursorLineNr = { fg = colors.orange, bold = true }
        highlights.LineNr = { fg = colors.fg_gutter, bold = true }
        highlights.LineNrAbove = { fg = colors.fg_gutter, bold = true }
        highlights.LineNrBelow = { fg = colors.fg_gutter, bold = true }

        highlights.WinSeparator = { fg = colors.comment }

        highlights.TelescopeResultsComment = { fg = colors.fg_dark }
      end,
    },
  },
}
