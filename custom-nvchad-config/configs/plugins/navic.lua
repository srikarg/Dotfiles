local present, navic = pcall(require, 'nvim-navic')

if not present then
  return
end

dofile(vim.g.base46_cache .. 'navic')

navic.setup({
  highlight = true,

  lsp = { auto_attach = true },
})
