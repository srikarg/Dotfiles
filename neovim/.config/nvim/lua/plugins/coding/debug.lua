return {
  'mfussenegger/nvim-dap',

  event = 'VeryLazy',

  dependencies = {
    {
      'rcarriga/nvim-dap-ui',

      dependencies = {
        'nvim-neotest/nvim-nio',
      },
    },
    {
      'theHamsta/nvim-dap-virtual-text',

      config = true,
    },

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
  },

  config = function()
    local dap = require('dap')
    local dapui = require('dapui')
    local icons = require('config').icons

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

    vim.keymap.set(
      'n',
      '<leader>dt',
      dap.terminate,
      { desc = 'Debug: Terminate Session' }
    )

    vim.keymap.set(
      'n',
      '<leader>dh',
      require('dap.ui.widgets').hover,
      { desc = 'Debug: Hover Current Variable' }
    )

    vim.keymap.set(
      'n',
      '<leader>dp',
      require('dap.ui.widgets').preview,
      { desc = 'Debug: Preview Current Variable' }
    )

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup({
      icons = icons.dap.ui.icons,
      controls = {
        icons = icons.dap.ui.controls,
      },
    })

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

    if vim.fn.filereadable('.vscode/launch.json') then
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
    end

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

    -- Provide backup configurations for these filetypes in case a `launch.json`
    -- file is not present for the current project.
    for _, language in ipairs({
      'typescript',
      'javascript',
      'typescriptreact',
      'javascriptreact',
    }) do
      if not dap.configurations[language] then
        dap.configurations[language] = {
          {
            type = 'pwa-node',
            request = 'launch',
            name = 'Launch Current File',
            program = '${file}',
            cwd = '${workspaceFolder}',
          },
          {
            type = 'pwa-node',
            request = 'attach',
            name = 'Attach',
            processId = require('dap.utils').pick_process,
            cwd = '${workspaceFolder}',
          },
          {
            type = 'pwa-node',
            request = 'launch',
            name = 'Launch Current File with Deno',
            program = '${file}',
            cwd = '${workspaceFolder}',
            runtimeExecutable = 'deno',
            runtimeArgs = {
              'run',
              '--unstable',
              '--import-map',
              './import_map.json',
              '--inspect-brk',
              '--allow-all',
            },
            attachSimplePort = 9229,
          },
        }
      end
    end
  end,
}
