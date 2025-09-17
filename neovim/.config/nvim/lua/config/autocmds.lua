-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Autofixes on Save
vim.g.autofixes_enabled = true

Snacks.toggle
  .new({
    name = 'Autofixes on Save',
    get = function()
      return vim.g.autofixes_enabled
    end,
    set = function(state)
      vim.g.autofixes_enabled = state
    end,
  })
  :map('<leader>uq', { desc = 'Autofixes on Save' })

vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('Python Autofixes on Save', { clear = true }),
  pattern = { '*.py' },
  callback = function()
    if vim.g.autofixes_enabled then
      vim.lsp.buf.code_action({
        apply = true,
        context = {
          only = {
            'source.fixAll.ruff',
          },
          diagnostics = {},
        },
      })

      vim.lsp.buf.code_action({
        apply = true,
        context = {
          only = {
            'source.organizeImports.ruff',
          },
          diagnostics = {},
        },
      })
    end
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('TS/TSX Autofixes On Save', { clear = true }),
  pattern = { '*.ts', '*.tsx' },
  callback = function()
    if vim.g.autofixes_enabled then
      vim.lsp.buf.code_action({
        apply = true,
        context = {
          only = {
            'source.addMissingImports.ts',
          },
          diagnostics = {},
        },
      })
      vim.lsp.buf.code_action({
        apply = true,
        context = {
          only = {
            'source.removeUnused.ts',
          },
          diagnostics = {},
        },
      })
    end
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('ESLint Autofixes On Save', { clear = true }),
  pattern = { '*.ts', '*.tsx', '*.js', '*.jsx' },
  callback = function()
    if vim.g.autofixes_enabled then
      vim.cmd('silent! LspEslintFixAll')
    end
  end,
})
