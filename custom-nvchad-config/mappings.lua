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
      '[t]oggle between [l]ight/dark theme',
    },
  },
}

M.tabufline = {
  n = {
    ['<leader>X'] = {
      function()
        require('nvchad.tabufline').closeAllBufs()
      end,
      'close all buffers',
    },

    ['<leader>C'] = {
      function()
        require('nvchad.tabufline').closeOtherBufs()
      end,
      'close all buffers except current one',
    },
  },
}

M.trouble = {
  n = {
    ['<leader>tt'] = { '<cmd> TroubleToggle <CR>', '[t]oggle [t]rouble' },
  },
}

M.navbuddy = {
  n = {
    ['<leader>N'] = {
      '<cmd> :lua require("nvim-navbuddy").open() <CR>',
      'open [N]avbuddy',
    },
  },
}

M.gitlinker = {
  n = {
    ['<leader>gy'] = {
      function()
        require('gitlinker').get_buf_range_url('n')
      end,
      '[g]it [y]ank URL for current line(s)',
    },
    ['<leader>go'] = {
      function()
        require('gitlinker').get_buf_range_url(
          'n',
          { action_callback = require('gitlinker.actions').open_in_browser }
        )
      end,
      '[g]it [o]pen URL for current line(s)',
      opts = { silent = true },
    },
  },
  v = {
    ['<leader>gy'] = {
      function()
        require('gitlinker').get_buf_range_url('v')
      end,
      '[g]it [y]ank URL for current line(s)',
    },
    ['<leader>go'] = {
      function()
        require('gitlinker').get_buf_range_url(
          'v',
          { action_callback = require('gitlinker.actions').open_in_browser }
        )
      end,
      '[g]it [o]pen URL for current line(s)',
    },
  },
}

M.telescope = {
  n = {
    -- Miscellaneous
    ['<leader>fc'] = {
      '<cmd> Telescope current_buffer_fuzzy_find <CR>',
      '[f]ind in [c]urrent buffer',
    },

    -- Telescope Git Commands
    ['<leader>gc'] = { '<cmd> Telescope git_commits <CR>', '[g]it [c]ommits' },
    ['<leader>gs'] = { '<cmd> Telescope git_status <CR>', '[g]it [s]tatus' },
    ['<leader>gb'] = { '<cmd> Telescope git_branches <CR>', '[g]it [b]ranches' },
    ['<leader>fg'] = { '<cmd> Telescope git_files <CR>', '[f]ind [g]it files' },

    -- Telescope LSP Commands
    ['<leader>ld'] = {
      '<cmd> Telescope lsp_document_symbols <CR>',
      'search [l]sp [d]ocument symbols',
    },
    ['<leader>lw'] = {
      '<cmd> Telescope lsp_dynamic_workspace_symbols <CR>',
      'search [l]sp [w]orkspace symbols',
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
      '[s]tage git [h]unk',
    },
    ['<leader>hr'] = {
      function()
        require('gitsigns').reset_hunk()
      end,
      '[r]eset git [h]unk',
    },
    ['<leader>hS'] = {
      function()
        require('gitsigns').stage_buffer()
      end,
      '[S]tage all hunks in buffer',
    },
    ['<leader>hu'] = {
      function()
        require('gitsigns').undo_stage_hunk()
      end,
      '[u]ndo stage of git [h]unk',
    },
    ['<leader>hR'] = {
      function()
        require('gitsigns').reset_buffer()
      end,
      '[R]eset all git hunks in buffer',
    },
    ['<leader>hp'] = {
      function()
        require('gitsigns').preview_hunk_inline()
      end,
      '[p]review git [h]unk inline',
    },
    ['<leader>hb'] = {
      function()
        require('gitsigns').blame_line({ full = true })
      end,
      'git [b]lame for current line',
    },
    ['<leader>tb'] = {
      function()
        require('gitsigns').toggle_current_line_blame()
      end,
      '[t]oggle git line [b]lame',
    },
    ['<leader>hd'] = {
      function()
        require('gitsigns').diffthis()
      end,
      '[d]iff this buffer',
    },
    ['<leader>hD'] = {
      function()
        require('gitsigns').diffthis('~')
      end,
      '[D]iff this buffer against ~',
    },
    ['<leader>td'] = {
      function()
        require('gitsigns').toggle_deleted()
      end,
      '[t]oggle [d]eleted lines',
    },
  },
}

M.nvterm = {
  n = {
    ['<leader>H'] = {
      function()
        require('nvterm.terminal').new('horizontal')
      end,
      'new [H]orizontal terminal',
    },

    ['<leader>V'] = {
      function()
        require('nvterm.terminal').new('vertical')
      end,
      'new [V]ertical terminal',
    },
  },
}

M.neogen = {
  n = {
    ['<leader>gd'] = {
      function()
        require('neogen').generate()
      end,
      '[g]enerate [d]ocumentation for current function',
    },
  },
}

-- more keybinds!

return M
