return {
  'folke/tokyonight.nvim',

  lazy = false,

  priority = 1000,

  config = function()
    local colorscheme = require('config').colorscheme

    local opts = {
      style = colorscheme:gsub('tokyonight-', ''), -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
      light_style = 'day', -- The theme is used when the background is set to light
      transparent = false, -- Enable this to disable setting the background color
      terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
      styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = 'dark', -- style for sidebars, see below
        floats = 'dark', -- style for floating windows
      },
      sidebars = { 'qf', 'help', 'lazy', 'mason' }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
      day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
      hide_inactive_statusline = true, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
      dim_inactive = true, -- dims inactive windows
      lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold

      --- You can override specific color groups to use other groups or a hex color
      --- function will be called with a ColorScheme table
      ---@param colors ColorScheme
      on_colors = function(colors)
        -- Change window split border color to something more visible (so I can
        -- resize splits via mouse easily)
        colors.border = colors.fg_gutter
      end,

      --- You can override specific highlights to use other groups or a hex color
      --- function will be called with a Highlights and ColorScheme table
      ---@param highlights Highlights
      ---@param colors ColorScheme
      on_highlights = function(highlights, colors)
        highlights.DiagnosticUnnecessary = { fg = colors.comment }

        highlights.CursorLineNr = { fg = colors.orange, bold = true }
        highlights.LineNrAbove = { fg = colors.fg_gutter, bold = true }
        highlights.LineNrBelow = { fg = colors.fg_gutter, bold = true }

        highlights.BufferLineFill = { fg = colors.fg, bg = colors.bg }

        highlights.StatusLine = { fg = colors.fg, bg = colors.bg }
        highlights.StatusLineNC = { fg = colors.fg, bg = colors.bg }

        local prompt = '#2d3149'
        highlights.TelescopeNormal =
          { bg = colors.bg_dark, fg = colors.fg_dark, bold = true }
        highlights.TelescopeBorder =
          { bg = colors.bg_dark, fg = colors.bg_dark }
        highlights.TelescopePromptNormal = { bg = prompt }
        highlights.TelescopePromptBorder = { bg = prompt, fg = prompt }
        highlights.TelescopePromptTitle =
          { bg = colors.fg_gutter, fg = colors.orange }
        highlights.TelescopePreviewTitle =
          { bg = colors.bg_dark, fg = colors.bg_dark }
        highlights.TelescopeResultsTitle =
          { bg = colors.bg_dark, fg = colors.bg_dark }
      end,
    }

    require('tokyonight').setup(opts)
    vim.cmd.colorscheme(colorscheme)

    local colors = require('tokyonight.colors').setup(opts)

    local highlights = {
      NeotestPassedStatusLine = {
        fg = colors.green,
        bg = colors.bg_statusline,
      },

      NeotestFailedStatusLine = {
        fg = colors.error,
        bg = colors.bg_statusline,
      },

      NeotestRunningStatusLine = {
        fg = colors.yellow,
        bg = colors.bg_statusline,
      },

      NeotestSkippedStatusLine = {
        fg = colors.cyan,
        bg = colors.bg_statusline,
      },

      HighlightUndo = {
        bg = colors.blue,
        fg = colors.bg,
      },
    }

    for group, args in pairs(highlights) do
      vim.api.nvim_set_hl(0, group, args)
    end
  end,
}
