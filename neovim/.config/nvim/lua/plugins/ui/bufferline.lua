return {
  'akinsho/bufferline.nvim',

  event = 'VeryLazy',

  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'echasnovski/mini.bufremove',
  },

  keys = {
    {
      '<leader>C',
      '<CMD> BufferLineCloseOthers <CR>',
      desc = 'Close All Buffers Except Current One',
      silent = true,
    },

    {
      'L',
      '<CMD> BufferLineCycleNext <CR>',
      desc = 'Go To Next Buffer',
      nowait = true,
      silent = true,
    },

    {
      'H',
      '<CMD> BufferLineCyclePrev <CR>',
      desc = 'Go To Previous Buffer',
      nowait = true,
      silent = true,
    },
  },

  opts = {
    options = {
      modified_icon = '',
      close_command = function(n)
        require('mini.bufremove').delete(n, false)
      end,
      right_mouse_command = function(n)
        require('mini.bufremove').delete(n, false)
      end,
      diagnostics = 'nvim_lsp',
      always_show_bufferline = true,
      color_icons = true,
      diagnostics_indicator = function(_, _, diag)
        local icons = require('config').icons.diagnostics
        local ret = (diag.error and icons.Error .. diag.error .. ' ' or '')
          .. (diag.warning and icons.Warn .. diag.warning or '')
        return vim.trim(ret)
      end,
      offsets = {
        {
          filetype = 'NvimTree',
          text = 'File Explorer',
          highlight = 'Directory',
          text_align = 'left',
        },
      },
    },
  },
}
