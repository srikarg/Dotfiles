return {
  'mfussenegger/nvim-dap',

  event = 'VeryLazy',

  dependencies = {
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
  },

  config = function()
    local dap = require('dap')
    local dapui = require('dapui')

    require('mason-nvim-dap').setup({
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      ensure_installed = {
        'js',
      },
    })

    vim.keymap.set(
      'n',
      '<leader>dr',
      dap.continue,
      { desc = 'Debug: Start/Continue' }
    )

    vim.keymap.set(
      'n',
      '<leader>di',
      dap.step_into,
      { desc = 'Debug: Step Into' }
    )

    vim.keymap.set(
      'n',
      '<leader>do',
      dap.step_over,
      { desc = 'Debug: Step Over' }
    )

    vim.keymap.set(
      'n',
      '<leader>dO',
      dap.step_out,
      { desc = 'Debug: Step Out' }
    )

    vim.keymap.set(
      'n',
      '<leader>db',
      dap.toggle_breakpoint,
      { desc = 'Debug: Toggle Breakpoint' }
    )

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup({
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    })

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set(
      'n',
      '<leader>dt',
      dapui.toggle,
      { desc = 'Debug: See last session result.' }
    )

    local create_cmd = vim.api.nvim_create_user_command

    create_cmd('DapUiOpen', ":lua require'dapui'.open()", {})
    create_cmd('DapUiClose', ":lua require'dapui'.close()", {})
    create_cmd('DapUiToggle', ":lua require'dapui'.toggle()", {})
    create_cmd('DapUiFloatElement', ":lua require'dapui'.float_element()", {})
    create_cmd('DapUiEval', ":lua require'dapui'.eval()", {})

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    vim.api.nvim_set_hl(
      0,
      'DapStoppedLine',
      { default = true, link = 'Visual' }
    )

    for name, sign in pairs(require('config').icons.dap) do
      sign = type(sign) == 'table' and sign or { sign }
      vim.fn.sign_define('Dap' .. name, {
        text = sign[1],
        texthl = sign[2] or 'DiagnosticInfo',
        linehl = sign[3],
        numhl = sign[3],
      })
    end

    require('dap.ext.vscode').load_launchjs(nil, {
      ['pwa-node'] = {
        'javascript',
        'typescript',
      },
      ['node'] = {
        'javascript',
        'typescript',
      },
    })

    dap.adapters['pwa-node'] = {
      type = 'server',
      host = 'localhost',
      port = '${port}',
      executable = {
        command = 'js-debug-adapter',
        args = { '${port}' },
      },
    }

    dap.adapters['node'] = {
      type = 'server',
      host = 'localhost',
      port = '${port}',
      executable = {
        command = 'js-debug-adapter',
        args = { '${port}' },
      },
    }
  end,
}
