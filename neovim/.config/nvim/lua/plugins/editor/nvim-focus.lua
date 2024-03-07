return {
  'nvim-focus/focus.nvim',

  lazy = false,

  config = function()
    require('focus').setup({
      enable = true, -- Enable module
      commands = true, -- Create Focus commands
      autoresize = {
        enable = true, -- Enable or disable auto-resizing of splits
        width = 0, -- Force width for the focused window
        height = 0, -- Force height for the focused window
        minwidth = 40, -- Force minimum width for the unfocused window
        minheight = 20, -- Force minimum height for the unfocused window
        height_quickfix = 10, -- Set the height of quickfix panel
      },
      split = {
        bufnew = false, -- Create blank buffer for new split windows
        tmux = false, -- Create tmux splits instead of neovim splits
      },
      ui = {
        number = false, -- Display line numbers in the focused window only
        relativenumber = false, -- Display relative line numbers in the focused window only
        hybridnumber = false, -- Display hybrid line numbers in the focused window only
        absolutenumber_unfocussed = false, -- Preserve absolute numbers in the unfocused windows

        cursorline = false, -- Display a cursorline in the focused window only
        cursorcolumn = false, -- Display cursorcolumn in the focused window only
        colorcolumn = {
          enable = true, -- Display colorcolumn in the focused window only
          list = '+1', -- Set the comma-separated list for the colorcolumn
        },
        signcolumn = false, -- Display signcolumn in the focused window only
        winhighlight = false, -- Auto highlighting for focused/unfocused windows
      },
    })

    -- Splits
    vim.keymap.set(
      'n',
      '<leader>V',
      '<CMD> FocusSplitRight <CR>',
      { desc = 'Vertical Split', nowait = true }
    )

    vim.keymap.set(
      'n',
      '<leader>H',
      '<CMD> FocusSplitDown <CR>',
      { desc = 'Horizontal Split', nowait = true }
    )

    local autocmd = vim.api.nvim_create_autocmd

    local ignore_filetypes = {
      'NvimTree',
      'DiffviewFiles',
      'Trouble',
      'terminal',
      'noice',
      'dap-repl',
      'dapui_console',
      'dapui_watches',
      'dapui_stacks',
      'dapui_breakpoints',
      'dapui_scopes',
    }
    local ignore_buftypes = {}

    local focus_group =
      vim.api.nvim_create_augroup('FocusDisable', { clear = true })

    -- Auto resize panes when resizing nvim window
    autocmd('VimResized', {
      pattern = '*',
      command = 'FocusAutoresize',
    })

    autocmd('WinEnter', {
      group = focus_group,
      callback = function(_)
        if vim.tbl_contains(ignore_buftypes, vim.bo.buftype) then
          vim.w.focus_disable = true
        else
          vim.w.focus_disable = false
        end
      end,
      desc = 'Disable focus autoresize for BufType',
    })

    autocmd('FileType', {
      group = focus_group,
      callback = function(_)
        if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
          vim.b.focus_disable = true
        else
          vim.b.focus_disable = false
        end
      end,
      desc = 'Disable focus autoresize for FileType',
    })
  end,
}
