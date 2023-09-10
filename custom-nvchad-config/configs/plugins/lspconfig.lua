local on_attach_nvchad = require('plugins.configs.lspconfig').on_attach
local capabilities = require('plugins.configs.lspconfig').capabilities

local on_attach = function(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    require('nvim-navic').attach(client, bufnr)
  end

  on_attach_nvchad(client, bufnr)
end

local lspconfig = require('lspconfig')

-- Provide default configuration for the following LSP servers:
local servers = {
  'html',
  'cssls',
  'tailwindcss',
  'tsserver',
  'astro',
  'svelte',
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

lspconfig.yamlls.setup({
  settings = {
    yaml = {
      format = { enable = true, singleQuote = true, bracketSpacing = true },
      validate = true,
      completion = true,
      schemaStore = { enable = false, url = '' },
      editor = { formatOnType = true },
      schemas = require('schemastore').yaml.schemas(),
    },
    redhat = {
      telemetry = {
        enabled = false,
      },
    },
  },
  on_attach = on_attach,
  capabilities = capabilities,
})
