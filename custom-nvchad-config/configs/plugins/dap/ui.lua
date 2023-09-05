local dapPresent, dap = pcall(require, 'dap')
local dapUiPresent, dapui = pcall(require, 'dapui')

if not dapPresent or not dapUiPresent then
  return
end

dapui.setup({
  icons = { expanded = '▾', collapsed = '▸' },
  mappings = {
    expand = { '<CR>', '<2-LeftMouse>' },
    open = 'o',
    remove = 'd',
    edit = 'e',
    repl = 'r',
    toggle = 't',
  },
  expand_lines = false,
  layouts = {
    {
      elements = {
        { id = 'scopes', size = 0.40 },
        { id = 'breakpoints', size = 0.20 },
        { id = 'stacks', size = 0.20 },
        { id = 'watches', size = 0.20 },
      },
      size = 40,
      position = 'left',
    },
    {
      elements = {
        {
          id = 'repl',
          size = 0.5,
        },
        {
          id = 'console',
          size = 0.5,
        },
      },
      size = 10,
      position = 'bottom',
    },
  },
  floating = {
    max_height = nil,
    max_width = nil,
    border = 'single',
    mappings = {
      close = { 'q', '<Esc>' },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil,
  },
})

dofile(vim.g.base46_cache .. 'dap')

vim.fn.sign_define(
  'DapBreakpoint',
  { text = '', numhl = 'DapBreakpoint', texthl = 'DapBreakpoint' }
)

vim.fn.sign_define(
  'DapBreakpointCondition',
  { text = 'C', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' }
)

vim.fn.sign_define(
  'DagLogPoint',
  { text = '', numhl = 'DapLogPoint', texthl = 'DapLogPoint' }
)

vim.fn.sign_define(
  'DapStopped',
  { text = '', numhl = 'DapStopped', texthl = 'DapStopped' }
)

vim.fn.sign_define('DapBreakpointRejected', {
  text = '',
  numhl = 'DapBreakpointRejected',
  texthl = 'DapBreakpointRejected',
})

dap.listeners.after.event_initialized['dapui_config'] = function()
  dapui.open()
end

dap.listeners.before.event_terminated['dapui_config'] = function()
  dapui.close()
end

dap.listeners.before.event_exited['dapui_config'] = function()
  dapui.close()
end
