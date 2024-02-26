return {
  'b0o/incline.nvim',

  event = 'VeryLazy',

  dependencies = { 'SmiteshP/nvim-navic', 'nvim-web-devicons' },

  opts = function()
    local helpers = require('incline.helpers')
    local navic = require('nvim-navic')
    local devicons = require('nvim-web-devicons')

    return {
      window = {
        padding = 0,
        margin = {
          horizontal = 0,
          vertical = 0,
        },
      },
      render = function(props)
        local colorscheme =
          require('config').colorscheme:gsub('tokyonight-', '')
        local tokyonight_colors =
          require('tokyonight.colors').setup({ style = colorscheme })
        local filename =
          vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
        if filename == '' then
          filename = '[No Name]'
        end
        local ft_icon, ft_color = devicons.get_icon_color(filename)
        local modified = vim.bo[props.buf].modified
        local res = {
          ft_icon and {
            ' ',
            ft_icon,
            ' ',
            guibg = ft_color,
            guifg = helpers.contrast_color(ft_color),
          } or {
            ' ',
            '',
            ' ',
            guibg = tokyonight_colors.blue,
            guifg = tokyonight_colors.bg_dark,
          },
          ' ',
          { filename, gui = modified and 'bold,italic' or 'bold' },
          guibg = tokyonight_colors.bg_dark,
        }
        if props.focused then
          for _, item in ipairs(navic.get_data(props.buf) or {}) do
            table.insert(res, {
              { ' > ', group = 'NavicSeparator' },
              { item.icon, group = 'NavicIcons' .. item.type },
              { item.name, group = 'NavicText' },
            })
          end
        end
        table.insert(res, ' ')
        return res
      end,
    }
  end,
}
