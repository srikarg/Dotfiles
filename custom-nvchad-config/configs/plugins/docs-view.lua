local present, docs_view = pcall(require, 'docs-view')

if not present then
  return
end

docs_view.setup({
  position = 'bottom',
  height = 20,
  width = 60,
  update_mode = 'auto',
})
