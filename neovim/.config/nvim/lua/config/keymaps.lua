-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- When diagnostic lines are on, turn virtual text off and vice-versa.
vim.keymap.set('', '<leader>bl', function()
  vim.diagnostic.config({
    virtual_lines = not vim.diagnostic.config().virtual_lines,
    virtual_text = not vim.diagnostic.config().virtual_text,
  })
end, { desc = 'Toggle Diagnostic [l]ines' })

vim.keymap.set('', '<leader>gp', function()
  vim.cmd('r !git log --pretty=format:"- \\%B" develop..HEAD')
end, { desc = '  Paste Git Commit Messages Since Develop' })

vim.keymap.set('', '<leader>qr', function()
  vim.cmd('restart')
end, { desc = 'Restart Neovim' })

-- If we're on at least nvim version 0.13, enable additional multicursor keymaps
if vim.fn.has('nvim-0.13') == 1 then
  local multi_cursor_utils = require('utils.multicursor')

  -- <C-n>: Add a multicursor at the next occurrence of the word under the
  -- cursor. Each press pins the current spot and hops to the next match, with
  -- follow mode on so edits replay at every pinned cursor. Stops when the loop
  -- wraps back to the first pinned spot.
  vim.keymap.set('n', '<C-n>', function()
    if multi_cursor_utils.has_multi_cursor_in_buffer() then
      -- Later press: the primary cursor sits on the next occurrence (the `n`
      -- of the last press brought us here). Bail if that exact spot is
      -- already pinned: the loop wrapped, and Q there would REMOVE a cursor.
      local row, col = unpack(vim.api.nvim_win_get_cursor(0))

      -- The `row - 1` translation is needed here since `win_get_cursor` rows
      -- are 1-indexed, `extmark` rows 0-indexed (columns are 0-indexed in
      -- both).
      if multi_cursor_utils.has_multi_cursor_at_position({ row - 1, col }) then
        return
      end
    else
      -- First press: no cursors yet. The word under the cursor drives the
      -- search.
      local word = vim.fn.expand('<cword>')

      if word == '' then
        return
      end

      -- Whole-word pattern. \< .. \> = word boundaries; escape() keeps any
      -- literal \ and / in the word (both are special inside the search reg).
      local pattern = [[\<]] .. vim.fn.escape(word, [[\/]]) .. [[\>]]

      -- Make the `n` (below) find occurrences, and highlight matches.
      vim.fn.setreg('/', pattern)
      vim.o.hlsearch = true

      -- Flags: 'b' backward · 'c' accept match at cursor · 'W' never wrap.
      -- If the cursor is mid-word, no match starts at that column, so 'c'
      -- passes it by and 'b' lands on the word's own start. The `n` in
      -- Qn1q= then reaches the first occurrence without skipping it.
      vim.fn.search(pattern, 'bcW')
    end

    -- Q: pin a cursor at this spot · n: jump to the next match ·
    -- 1q=: enable follow mode (edits replay at all cursors).
    vim.cmd('normal! Qn1q=')
  end, { desc = 'Add multicursor at next occurrence of word under cursor' })

  -- If multicursors are active, make <C-l> trigger the default CTRL-L behavior
  -- of nvim (nohlsearch, diffupdate, clear cursors, redraw).
  --
  -- Else, navigate to the window on the right using the
  -- `christoomey/vim-tmux-navigator` plugin
  vim.keymap.set({ 'n', 'x' }, '<C-l>', function()
    if multi_cursor_utils.has_multi_cursor_in_buffer() then
      vim.cmd('nohlsearch | diffupdate')
      multi_cursor_utils.clear_multi_cursors_in_buffer()
      vim.api.nvim_feedkeys(vim.keycode('<C-L>'), 'n', false)
      return
    end
    vim.cmd('TmuxNavigateRight')
  end, { desc = 'Default CTRL-L or Navigate to Window on the Right' })
end
