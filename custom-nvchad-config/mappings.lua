---@type MappingsTable
local M = {}

M.disabled = {
  n = {
    ['<leader>cm'] = '',
    ['<leader>gt'] = '',
    ['<leader>ph'] = '',
    ['<leader>rh'] = '',
    ['<leader>fz'] = '',
    ['<leader>h'] = '',
    ['<leader>v'] = '',
  },
}

M.general = {
  n = {
    --- Miscellaneous
    [';'] = { ':', 'Enter Command Mode', opts = { nowait = true } },
    ['<C-d>'] = { '<C-d>zz', 'Page Down and Center', opts = { nowait = true } },
    ['<C-u>'] = { '<C-u>zz', 'Page Up and Center', opts = { nowait = true } },

    --- Themes
    ['<leader>tl'] = {
      function()
        require('base46').toggle_theme()
      end,
      'Toggle Light/Dark Theme',
    },
  },
}

M.trouble = {
  n = {
    ['<leader>tt'] = { '<cmd> TroubleToggle <CR>', 'Toggle Trouble' },
  },
}

M.telescope = {
  n = {
    -- Miscellaneous
    ['<leader>fc'] = {
      '<cmd> Telescope current_buffer_fuzzy_find <CR>',
      'Fuzzy Search in Current Buffer',
    },

    -- Telescope Git Commands
    ['<leader>gc'] = { '<cmd> Telescope git_commits <CR>', 'Git Commits' },
    ['<leader>gs'] = { '<cmd> Telescope git_status <CR>', 'Git Status' },
    ['<leader>gb'] = { '<cmd> Telescope git_branches <CR>', 'Git Branches' },
    ['<leader>gf'] = { '<cmd> Telescope git_files <CR>', 'Search Git Files' },
  },
}

M.gitsigns = {
  n = {
    -- Navigation through Git hunks
    [']c'] = {
      function()
        if vim.wo.diff then
          return ']c'
        end
        vim.schedule(function()
          require('gitsigns').next_hunk()
        end)
        return '<Ignore>'
      end,
      'Jump To Next Hunk',
      opts = { expr = true },
    },
    ['[c'] = {
      function()
        if vim.wo.diff then
          return '[c'
        end
        vim.schedule(function()
          require('gitsigns').prev_hunk()
        end)
        return '<Ignore>'
      end,
      'Jump To Previous Hunk',
      opts = { expr = true },
    },

    -- Git actions
    ['<leader>hs'] = {
      function()
        require('gitsigns').stage_hunk()
      end,
      'Stage Hunk',
    },
    ['<leader>hr'] = {
      function()
        require('gitsigns').reset_hunk()
      end,
      'Reset Hunk',
    },
    ['<leader>hS'] = {
      function()
        require('gitsigns').stage_buffer()
      end,
      'Stage Buffer',
    },
    ['<leader>hu'] = {
      function()
        require('gitsigns').undo_stage_hunk()
      end,
      'Undo Stage Hunk',
    },
    ['<leader>hR'] = {
      function()
        require('gitsigns').reset_buffer()
      end,
      'Reset Buffer',
    },
    ['<leader>hp'] = {
      function()
        require('gitsigns').preview_hunk_inline()
      end,
      'Preview Hunk Inline',
    },
    ['<leader>hb'] = {
      function()
        require('gitsigns').blame_line({ full = true })
      end,
      'Git Blame for Current Line',
    },
    ['<leader>tb'] = {
      function()
        require('gitsigns').toggle_current_line_blame()
      end,
      'Toggle Git Line Blame',
    },
    ['<leader>hd'] = {
      function()
        require('gitsigns').diffthis()
      end,
      'Diff This Buffer',
    },
    ['<leader>hD'] = {
      function()
        require('gitsigns').diffthis('~')
      end,
      'Diff This Buffer Against ~',
    },
    ['<leader>td'] = {
      function()
        require('gitsigns').toggle_deleted()
      end,
      'Toggle Deleted Lines',
    },
  },
}

M.nvterm = {
  n = {
    ['<leader>H'] = {
      function()
        require('nvterm.terminal').new('horizontal')
      end,
      'New Horizontal Terminal',
    },

    ['<leader>V'] = {
      function()
        require('nvterm.terminal').new('vertical')
      end,
      'New Vertical Terminal',
    },
  },
}

-- more keybinds!

return M
