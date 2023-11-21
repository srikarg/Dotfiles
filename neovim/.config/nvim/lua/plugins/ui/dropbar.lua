return {
  'Bekaboo/dropbar.nvim',

  dependencies = {
    'nvim-telescope/telescope-fzf-native.nvim',
  },

  opts = function()
    local api = require('dropbar.api')
    local utils = require('dropbar.utils')
    local sources = require('dropbar.sources')

    vim.keymap.set('n', '<leader>b', api.pick, { desc = 'Dropbar Pick Mode' })

    return {
      bar = {
        sources = function(buf, _)
          if vim.bo[buf].ft == 'markdown' then
            return {
              sources.markdown,
            }
          end
          if vim.bo[buf].buftype == 'terminal' then
            return {
              sources.terminal,
            }
          end
          return {
            utils.source.fallback({
              sources.lsp,
              sources.treesitter,
            }),
          }
        end,
      },
      menu = {
        keymaps = {
          ['q'] = '<C-w>q',

          ['h'] = '<C-w>c',

          ['l'] = function()
            local menu = utils.menu.get_current()

            if not menu then
              return
            end

            local cursor = vim.api.nvim_win_get_cursor(menu.win)
            local component = menu.entries[cursor[1]]:first_clickable(cursor[2])
            if component then
              menu:click_on(component, nil, 1, 'l')
            end
          end,
        },
      },
    }
  end,
}
