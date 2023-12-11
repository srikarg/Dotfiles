return {
  'echasnovski/mini.files',

  opts = {
    windows = {
      preview = true,
      width_focus = 30,
      width_preview = 30,
    },

    mappings = {
      close = 'q',
      go_in = '',
      go_in_plus = 'L',
      go_out = 'H',
      go_out_plus = '',
      reset = '<BS>',
      reveal_cwd = '@',
      show_help = 'g?',
      synchronize = '=',
      trim_left = '<',
      trim_right = '>',
    },

    options = {
      -- Whether to use for editing directories
      -- Disabled because nvim-tree is used for this
      use_as_default_explorer = false,
    },
  },

  keys = {
    {
      '<leader>fm',
      function()
        require('mini.files').open(vim.api.nvim_buf_get_name(0), true)
      end,
      desc = 'Open mini.files (directory of current file)',
    },
    {
      '<leader>fM',
      function()
        require('mini.files').open(vim.loop.cwd(), true)
      end,
      desc = 'Open mini.files (cwd)',
    },
  },

  config = function(_, opts)
    local MiniFiles = require('mini.files')
    MiniFiles.setup(opts)

    -- Mapping to toggle dotfiles
    local show_dotfiles = true
    local filter_show = function(fs_entry)
      return true
    end
    local filter_hide = function(fs_entry)
      return not vim.startswith(fs_entry.name, '.')
    end

    local toggle_dotfiles = function()
      show_dotfiles = not show_dotfiles
      local new_filter = show_dotfiles and filter_show or filter_hide
      MiniFiles.refresh({ content = { filter = new_filter } })
    end

    -- Mapping to open file with a split
    local map_split = function(buf_id, lhs, direction)
      local rhs = function()
        -- Make new window and set it as target
        local new_target_window
        vim.api.nvim_win_call(MiniFiles.get_target_window(), function()
          vim.cmd(direction .. ' split')
          new_target_window = vim.api.nvim_get_current_win()
        end)

        MiniFiles.set_target_window(new_target_window)
        MiniFiles.go_in()
        MiniFiles.close()
      end

      -- Adding `desc` will result into `show_help` entries
      local desc = 'Open File in Split ' .. direction
      vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
    end

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      callback = function(args)
        local buf_id = args.data.buf_id
        -- Tweak left-hand side of mapping to your liking
        map_split(buf_id, 'gh', 'belowright horizontal')
        map_split(buf_id, 'gv', 'belowright vertical')
        vim.keymap.set(
          'n',
          'g.',
          toggle_dotfiles,
          { buffer = buf_id, desc = 'Toggle Dotfiles' }
        )
      end,
    })
  end,
}
