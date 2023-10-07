return {
  -- Adds git related signs to the gutter, as well as utilities for managing changes
  'lewis6991/gitsigns.nvim',

  opts = {
    -- See `:help gitsigns.txt`
    signs = {
      add = { text = '│' },
      change = { text = '│' },
      delete = { text = '󰍵' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
      untracked = { text = '│' },
    },
    on_attach = function(bufnr)
      vim.keymap.set(
        'n',
        '<leader>hs',
        require('gitsigns').stage_hunk,
        { buffer = bufnr, desc = '[s]tage Git [h]unk' }
      )

      vim.keymap.set(
        'n',
        '<leader>hr',
        require('gitsigns').reset_hunk,
        { buffer = bufnr, desc = '[r]eset Git [h]unk' }
      )

      vim.keymap.set(
        'n',
        '<leader>hS',
        require('gitsigns').stage_buffer,
        { buffer = bufnr, desc = '[S]tage All Hunks in Buffer' }
      )

      vim.keymap.set(
        'n',
        '<leader>hu',
        require('gitsigns').undo_stage_hunk,
        { buffer = bufnr, desc = '[u]ndo Stage of Git [h]unk' }
      )

      vim.keymap.set(
        'n',
        '<leader>hR',
        require('gitsigns').reset_buffer,
        { buffer = bufnr, desc = '[R]eset All Git Hunks in Buffer' }
      )

      vim.keymap.set(
        'n',
        '<leader>hp',
        require('gitsigns').preview_hunk_inline,
        { buffer = bufnr, desc = '[p]review Git [h]unk Inline' }
      )

      vim.keymap.set('n', '<leader>hb', function()
        require('gitsigns').blame_line({ full = true })
      end, { buffer = bufnr, desc = 'Git [b]lame for Current Line' })

      vim.keymap.set(
        'n',
        '<leader>tb',
        require('gitsigns').toggle_current_line_blame,
        { buffer = bufnr, desc = '[t]oggle Git Line [b]lame' }
      )

      vim.keymap.set(
        'n',
        '<leader>hd',
        require('gitsigns').diffthis,
        { buffer = bufnr, desc = '[d]iff This Buffer' }
      )

      vim.keymap.set('n', '<leader>hD', function()
        require('gitsigns').diffthis('~')
      end, { buffer = bufnr, desc = '[D]iff This Buffer Against ~' })

      vim.keymap.set(
        'n',
        '<leader>td',
        require('gitsigns').toggle_deleted,
        { buffer = bufnr, desc = '[t]oggle [d]eleted Lines' }
      )

      vim.keymap.set(
        'n',
        '<leader>hp',
        require('gitsigns').preview_hunk,
        { buffer = bufnr, desc = 'Preview git hunk' }
      )

      -- don't override the built-in and fugitive keymaps
      local gs = package.loaded.gitsigns

      vim.keymap.set({ 'n', 'v' }, ']c', function()
        if vim.wo.diff then
          return ']c'
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return '<Ignore>'
      end, {
        expr = true,
        buffer = bufnr,
        desc = 'Jump to next hunk',
      })

      vim.keymap.set({ 'n', 'v' }, '[c', function()
        if vim.wo.diff then
          return '[c'
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return '<Ignore>'
      end, {
        expr = true,
        buffer = bufnr,
        desc = 'Jump to previous hunk',
      })
    end,
  },
}
