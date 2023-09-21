local present, null_ls = pcall(require, 'null-ls')

if not present then
  return
end

local group =
  vim.api.nvim_create_augroup('lsp_format_on_save', { clear = false })
local event = 'BufWritePre' -- or "BufWritePost"
local async = event == 'BufWritePost'

local null_ls_builtins = null_ls.builtins

local sources = {
  -- General
  null_ls_builtins.formatting.trim_whitespace,
  null_ls_builtins.completion.spell,

  -- Web Development
  null_ls_builtins.formatting.prettier.with({
    filetypes = {
      'astro',
      'css',
      'graphql',
      'handlebars',
      'html',
      'javascript',
      'javascriptreact',
      'json',
      'jsonc',
      'less',
      'markdown',
      'markdown.mdx',
      'scss',
      'svelte',
      'typescript',
      'typescriptreact',
      'vue',
      'yaml',
    },
    extra_args = { '--print-width', '80', '--prose-wrap', 'always' },
  }),

  -- Shell
  null_ls_builtins.formatting.shfmt.with({
    -- https://github.com/mvdan/sh/blob/master/cmd/shfmt/shfmt.1.scd
    extra_args = { '-i', '2', '-ci' },
  }),

  -- Lua
  null_ls_builtins.formatting.stylua,
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
