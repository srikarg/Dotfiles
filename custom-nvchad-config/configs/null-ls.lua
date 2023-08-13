local present, null_ls = pcall(require, 'null-ls')

if not present then
  return
end

local group =
  vim.api.nvim_create_augroup('lsp_format_on_save', { clear = false })
local event = 'BufWritePre' -- or "BufWritePost"
local async = event == 'BufWritePost'

local b = null_ls.builtins

local sources = {
  -- General
  b.formatting.trim_whitespace,
  b.completion.spell,

  -- Web Development
  b.diagnostics.eslint,
  b.formatting.prettier,

  -- Shell
  b.diagnostics.shellcheck,
  b.formatting.shfmt,

  -- Lua
  b.formatting.stylua,
}

null_ls.setup({
  debug = true,
  on_attach = function(client, bufnr)
    if client.supports_method('textDocument/formatting') then
      vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
      vim.api.nvim_create_autocmd(event, {
        group = group,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, async = async })
        end,
      })
    end
  end,
  sources = sources,
})
