return {
  -- Adds git related signs to the gutter, as well as utilities for managing changes
  'lewis6991/gitsigns.nvim',

  opts = {
    -- See `:help gitsigns.txt`
    signs = {
      add = { text = '▎' },
      change = { text = '▎' },
      delete = { text = '' },
      topdelete = { text = '' },
      changedelete = { text = '▎' },
      untracked = { text = '▎' },
    },
    on_attach = function(bufnr)
      vim.keymap.set(
        'n',
        '<leader>hs',
        require('gitsigns').stage_hunk,
        { buffer = bufnr, desc = '[S]tage Git [H]unk' }
      )

      vim.keymap.set(
        'n',
        '<leader>hr',
        require('gitsigns').reset_hunk,
        { buffer = bufnr, desc = '[R]eset Git [H]unk' }
      )

      vim.keymap.set(
        'n',
        '<leader>hS',
        require('gitsigns').stage_buffer,
        { buffer = bufnr, desc = '[S]tage All Hunks In Buffer' }
      )

      vim.keymap.set(
        'n',
        '<leader>hu',
        require('gitsigns').undo_stage_hunk,
        { buffer = bufnr, desc = '[U]ndo Stage Of Git [H]unk' }
      )

      vim.keymap.set(
        'n',
        '<leader>hR',
        require('gitsigns').reset_buffer,
        { buffer = bufnr, desc = '[R]eset All Git Hunks In Buffer' }
      )

      vim.keymap.set(
        'n',
        '<leader>hp',
        require('gitsigns').preview_hunk_inline,
        { buffer = bufnr, desc = '[P]review Git [H]unk Inline' }
      )

      vim.keymap.set('n', '<leader>hb', function()
        require('gitsigns').blame_line({ full = true })
      end, { buffer = bufnr, desc = 'Git [B]lame For Current Line' })

      vim.keymap.set(
        'n',
        '<leader>gtb',
        require('gitsigns').toggle_current_line_blame,
        { buffer = bufnr, desc = '[T]oggle [G]it Line [B]lame' }
      )

      vim.keymap.set(
        'n',
        '<leader>hd',
        require('gitsigns').diffthis,
        { buffer = bufnr, desc = '[D]iff This Buffer' }
      )

      vim.keymap.set('n', '<leader>hD', function()
        require('gitsigns').diffthis('~')
      end, { buffer = bufnr, desc = '[D]iff This Buffer Against ~' })

      vim.keymap.set(
        'n',
        '<leader>gtd',
        require('gitsigns').toggle_deleted,
        { buffer = bufnr, desc = '[T]oggle [G]it [D]eleted Lines' }
      )

      vim.keymap.set(
        'n',
        '<leader>hp',
        require('gitsigns').preview_hunk,
        { buffer = bufnr, desc = 'Preview Git Hunk' }
      )

      -- don't override the built-in and fugitive keymaps
      local gs = package.loaded.gitsigns

      vim.keymap.set({ 'n', 'v' }, ']c', function()
        if vim.wo.diff then
          return ']c'
        end
        vim.schedule(function()
          gs.next_hunk({ navigation_message = false, preview = true })
        end)
        return '<Ignore>'
      end, {
        expr = true,
        buffer = bufnr,
        desc = 'Jump to Next Hunk',
      })

      vim.keymap.set({ 'n', 'v' }, '[c', function()
        if vim.wo.diff then
          return '[c'
        end
        vim.schedule(function()
          gs.prev_hunk({ navigation_message = false, preview = true })
        end)
        return '<Ignore>'
      end, {
        expr = true,
        buffer = bufnr,
        desc = 'Jump to Previous Hunk',
      })
    end,
  },
}
