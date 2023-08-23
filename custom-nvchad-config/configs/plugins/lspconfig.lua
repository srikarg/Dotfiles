local on_attach = require('plugins.configs.lspconfig').on_attach
local capabilities = require('plugins.configs.lspconfig').capabilities

local lspconfig = require('lspconfig')

-- Provide default configuration for the following LSP servers:
local servers = {
  'html',
  'cssls',
  'tsserver',
  'docker_compose_language_service',
  'emmet_language_server',
  'bashls',
  'marksman',
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

lspconfig.eslint.setup({
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      command = 'EslintFixAll',
    })

    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
})

lspconfig.jsonls.setup({
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
  on_attach = on_attach,
  capabilities = capabilities,
})
