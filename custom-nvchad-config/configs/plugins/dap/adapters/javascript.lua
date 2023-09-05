local dapPresent, dap = pcall(require, 'dap')

if not dapPresent then
  return
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
