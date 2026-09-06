local multi_cursor_utils = require('utils.multicursor')

return {
  'monaqa/dial.nvim',

  keys = {
    -- This mapping preserves the native Neovim behavior of "g<C-a>" in normal
    -- mode: insert an ascending number at every cursor (1, 2, 3...), since the
    -- key is overwritten by the LazyVim `dial.nvim` extra:
    -- https://github.com/LazyVim/LazyVim/blob/459a4c3b1059671e766a46c7cc223827dc67e3d0/lua/lazyvim/plugins/extras/editor/dial.lua#L22
    {
      'g<C-a>',

      -- Follow mode replays a keypress at every cursor. The counter inserts a
      -- number at ALL cursors at once, so running it inside the keypress would
      -- get replayed and insert the numbers a second time. Deferring with
      -- vim.schedule moves the edit past the replay.
      function()
        if not multi_cursor_utils.has_multi_cursor_in_buffer() then
          return
        end
        -- vim.v.count1 = the count typed before the key, or 1 if none typed. It
        -- is the FIRST number of the sequence ("5g<C-a>" inserts 5, 6, 7). Read
        -- it now: the scheduled run happens after the keypress, when the count
        -- has already reset.
        local count1 = vim.v.count1

        vim.schedule(function()
          vim.cmd('normal! ' .. count1 .. vim.keycode('g<C-A>'))
        end)
      end,

      desc = 'Multicursor Counter',

      mode = 'n',
    },
  },
}
