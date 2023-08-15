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
    ['gd'] = '',
    ['gi'] = '',
    ['gr'] = '',
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

M.tabufline = {
  n = {
    ['<leader>X'] = {
      function()
        require('nvchad.tabufline').closeAllBufs()
      end,
      'Close all buffers',
    },

    ['<leader>C'] = {
      function()
        require('nvchad.tabufline').closeOtherBufs()
      end,
      'Close all buffers except current one',
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

    -- Telescope LSP Commands
    ['<leader>ld'] = {
      '<cmd> Telescope lsp_document_symbols <CR>',
      'Search [L]SP [D]ocument Symbols',
    },
    ['<leader>lw'] = {
      '<cmd> Telescope lsp_dynamic_workspace_symbols <CR>',
      'Search [L]SP [W]orkspace Symbols',
    },
    ['gd'] = {
      '<cmd> Telescope lsp_definitions <CR>',
      'Search All [L]SP [D]efinitions',
    },
    ['gi'] = {
      '<cmd> Telescope lsp_implementations <CR>',
      'Search All [L]SP [I]mplementations',
    },
    ['gr'] = {
      '<cmd> Telescope lsp_references <CR>',
      'Search All [L]SP [R]eferences',
    },
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
      '[S]tage Buffer',
    },
    ['<leader>hu'] = {
      function()
        require('gitsigns').undo_stage_hunk()
      end,
      'Undo [S]tage [H]unk',
    },
    ['<leader>hR'] = {
      function()
        require('gitsigns').reset_buffer()
      end,
      '[R]eset Buffer',
    },
    ['<leader>hp'] = {
      function()
        require('gitsigns').preview_hunk_inline()
      end,
      '[P]review [H]unk Inline',
    },
    ['<leader>hb'] = {
      function()
        require('gitsigns').blame_line({ full = true })
      end,
      'Git [B]lame for Current Line',
    },
    ['<leader>tb'] = {
      function()
        require('gitsigns').toggle_current_line_blame()
      end,
      '[T]oggle Git Line [B]lame',
    },
    ['<leader>hd'] = {
      function()
        require('gitsigns').diffthis()
      end,
      '[D]iff This Buffer',
    },
    ['<leader>hD'] = {
      function()
        require('gitsigns').diffthis('~')
      end,
      '[D]iff This Buffer Against ~',
    },
    ['<leader>td'] = {
      function()
        require('gitsigns').toggle_deleted()
      end,
      '[T]oggle [D]eleted Lines',
    },
  },
}

M.nvterm = {
  n = {
    ['<leader>H'] = {
      function()
        require('nvterm.terminal').new('horizontal')
      end,
      'New [H]orizontal Terminal',
    },

    ['<leader>V'] = {
      function()
        require('nvterm.terminal').new('vertical')
      end,
      'New [V]ertical Terminal',
    },
  },
}

M.neogen = {
  n = {
    ['<leader>gd'] = {
      function()
        require('neogen').generate()
      end,
      '[G]enerate [D]ocumentation for Current Function',
    },
  },
}

-- more keybinds!

return M
