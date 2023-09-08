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
    ['<leader>ra'] = '',
    ['<leader>fw'] = '',
    ['<leader>fo'] = '',
    ['<leader>q'] = '',
    ['<leader>f'] = '',
  },
}

M.general = {
  n = {
    --- Miscellaneous
    [';'] = { ':', 'Enter Command Mode', opts = { nowait = true } },
    ['<C-d>'] = { '<C-d>zz', 'Page Down and Center', opts = { nowait = true } },
    ['<C-u>'] = { '<C-u>zz', 'Page Up and Center', opts = { nowait = true } },

    -- Tmux Navigator
    ['<C-h>'] = {
      '<cmd> TmuxNavigateLeft<CR>',
      'Navigate to the Window on the Left',
    },
    ['<C-l>'] = {
      '<cmd> TmuxNavigateRight<CR>',
      'Navigate to the Window on the Right',
    },
    ['<C-j>'] = { '<cmd> TmuxNavigateDown<CR>', 'Navigate to the Window Below' },
    ['<C-k>'] = { '<cmd> TmuxNavigateUp<CR>', 'Navigate to the Window Above' },

    -- Undotree
    ['<leader>u'] = { '<cmd> UndotreeToggle<CR>', 'Toggle [u]ndotree Plugin' },
  },
}

M.dap = {
  plugin = true,

  n = {
    ['<leader>db'] = {
      '<cmd> DapToggleBreakpoint <CR>',
      'Toggle [d]ebugger [b]reakpoint',
    },

    ['<leader>dr'] = {
      '<cmd> DapContinue <CR>',
      '[d]ebugger [r]un/continue',
    },

    ['<leader>do'] = {
      '<cmd> DapStepOver <CR>',
      '[d]ebugger Step [o]ver',
    },

    ['<leader>dO'] = {
      '<cmd> DapStepOut <CR>',
      '[d]ebugger Step [O]ut',
    },

    ['<leader>di'] = {
      '<cmd> DapStepInto <CR>',
      '[d]ebugger Step [i]nto',
    },

    ['<leader>dt'] = {
      '<cmd> DapTerminate <CR>',
      '[d]ebugger [t]erminate',
    },

    ['<leader>dh'] = {
      function()
        require('dap.ui.widgets').hover()
      end,
      '[d]ebugger [h]over Current Variable',
    },

    ['<leader>dp'] = {
      function()
        require('dap.ui.widgets').preview()
      end,
      '[d]ebugger [p]review Current Variable',
    },
  },
}

M.docsview = {
  n = {
    ['<leader>dv'] = { '<cmd> DocsViewToggle<CR>', '[d]ocs [v]iew Toggle' },
  },
}

M.zenmode = {
  n = {
    ['<leader>z'] = {
      function()
        require('zen-mode').toggle()
      end,
      'Toggle [z]en Mode',
    },
  },
}

M.lspconfig = {
  n = {
    -- Miscellaneous
    ['<leader>lr'] = {
      function()
        require('nvchad.renamer').open()
      end,
      '[l]sp [r]ename',
    },
  },
}

M.tabufline = {
  n = {
    ['<leader>X'] = {
      function()
        require('nvchad.tabufline').closeAllBufs()
      end,
      'Close All Buffers',
    },

    ['<leader>C'] = {
      function()
        require('nvchad.tabufline').closeOtherBufs()
      end,
      'Close All Buffers Except Current One',
    },
  },
}

local diagnostics_active = true

M.diagnostics = {
  n = {
    ['<leader>qq'] = {
      '<cmd> TroubleToggle <CR>',
      'Toggle Diagnostics List (via Trouble plugin)',
    },
    ['<leader>qf'] = {
      function()
        vim.diagnostic.open_float({ border = 'rounded' })
      end,
      'Toggle Floating Diagnostic',
    },
    ['<leader>qt'] = {
      function()
        diagnostics_active = not diagnostics_active
        if diagnostics_active then
          vim.diagnostic.show()
        else
          vim.diagnostic.hide()
        end
      end,
      'Toggle Diagnostics Visibility',
    },
  },
}

M.navbuddy = {
  n = {
    ['<leader>N'] = {
      '<cmd> :lua require("nvim-navbuddy").open() <CR>',
      'Open [N]avbuddy',
    },
  },
}

M.gitlinker = {
  n = {
    ['<leader>gy'] = {
      function()
        require('gitlinker').get_buf_range_url('n')
      end,
      '[g]it [y]ank URL for Current Line(s)',
    },
    ['<leader>go'] = {
      function()
        require('gitlinker').get_buf_range_url(
          'n',
          { action_callback = require('gitlinker.actions').open_in_browser }
        )
      end,
      '[g]it [o]pen URL for Current Line(s)',
      opts = { silent = true },
    },
  },
  v = {
    ['<leader>gy'] = {
      function()
        require('gitlinker').get_buf_range_url('v')
      end,
      '[g]it [y]ank URL for Current Line(s)',
    },
    ['<leader>go'] = {
      function()
        require('gitlinker').get_buf_range_url(
          'v',
          { action_callback = require('gitlinker.actions').open_in_browser }
        )
      end,
      '[g]it [o]pen URL for Current Line(s)',
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
          vim.api.nvim_feedkeys('zz', 'n', false)
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
          vim.api.nvim_feedkeys('zz', 'n', false)
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
      '[s]tage Git [h]unk',
    },
    ['<leader>hr'] = {
      function()
        require('gitsigns').reset_hunk()
      end,
      '[r]eset Git [h]unk',
    },
    ['<leader>hS'] = {
      function()
        require('gitsigns').stage_buffer()
      end,
      '[S]tage All Hunks in Buffer',
    },
    ['<leader>hu'] = {
      function()
        require('gitsigns').undo_stage_hunk()
      end,
      '[u]ndo Stage of Git [h]unk',
    },
    ['<leader>hR'] = {
      function()
        require('gitsigns').reset_buffer()
      end,
      '[R]eset All Git Hunks in Buffer',
    },
    ['<leader>hp'] = {
      function()
        require('gitsigns').preview_hunk_inline()
      end,
      '[p]review Git [h]unk Inline',
    },
    ['<leader>hb'] = {
      function()
        require('gitsigns').blame_line({ full = true })
      end,
      'Git [b]lame for Current Line',
    },
    ['<leader>tb'] = {
      function()
        require('gitsigns').toggle_current_line_blame()
      end,
      '[t]oggle Git Line [b]lame',
    },
    ['<leader>hd'] = {
      function()
        require('gitsigns').diffthis()
      end,
      '[d]iff This Buffer',
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
      '[t]oggle [d]eleted Lines',
    },
  },

  v = {
    ['<leader>hs'] = {
      function()
        require('gitsigns').stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
      end,
      '[s]tage Git [h]unk',
    },
    ['<leader>hr'] = {
      function()
        require('gitsigns').reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
      end,
      '[r]eset Git [h]unk',
    },
  },
}

M.telescope = {
  n = {
    -- Miscellaneous
    ['<leader>fc'] = {
      '<cmd> Telescope current_buffer_fuzzy_find <CR>',
      '[f]ind In [c]urrent Buffer',
    },

    -- Finding recent files
    ['<leader>fo'] = {
      function()
        -- https://github.com/nvim-telescope/telescope.nvim/issues/2539#issuecomment-1562510095
        require('telescope.builtin').oldfiles({
          tiebreak = function(current_entry, existing_entry, _)
            return current_entry.index < existing_entry.index
          end,
        })
      end,
      '[f]ind [o]ldfiles',
    },

    -- Grepping
    ['<leader>fr'] = {
      function()
        require('telescope').extensions.live_grep_args.live_grep_args()
      end,
      '[f]ind g[r]ep',
    },
    ['<leader>fw'] = {
      function()
        require('telescope-live-grep-args.shortcuts').grep_word_under_cursor()
      end,
      '[f]ind [w]ord With Grep',
    },

    -- Telescope Git Commands
    ['<leader>gc'] = { '<cmd> Telescope git_commits <CR>', '[g]it [c]ommits' },
    ['<leader>gs'] = { '<cmd> Telescope git_status <CR>', '[g]it [s]tatus' },
    ['<leader>gb'] = { '<cmd> Telescope git_branches <CR>', '[g]it [b]ranches' },
    ['<leader>fg'] = { '<cmd> Telescope git_files <CR>', '[f]ind [g]it files' },

    -- Telescope LSP Commands
    ['<leader>ld'] = {
      '<cmd> Telescope lsp_document_symbols <CR>',
      'Search [l]sp [d]ocument Symbols',
    },
    ['<leader>lw'] = {
      '<cmd> Telescope lsp_dynamic_workspace_symbols <CR>',
      'Search [l]sp [w]orkspace Symbols',
    },
    ['gd'] = {
      '<cmd> Telescope lsp_definitions <CR>',
      '[g]o to [d]efinition',
    },
    ['gi'] = {
      '<cmd> Telescope lsp_implementations <CR>',
      '[g]o to [i]mplementation',
    },
    ['gr'] = {
      '<cmd> Telescope lsp_references <CR>',
      '[g]o to [r]eferences',
    },
  },

  v = {
    -- Grepping
    ['<leader>fr'] = {
      function()
        require('telescope-live-grep-args.shortcuts').grep_visual_selection()
      end,
      '[f]ind g[r]ep',
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
        require('neogen').generate({
          -- The annotation type to generate. Currently supported: func, class, type, file
          type = 'func',
        })
      end,
      '[g]enerate [d]ocumentation for Current Function',
    },
  },
}

return M
