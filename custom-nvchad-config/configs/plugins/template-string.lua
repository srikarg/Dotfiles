local present, template_string = pcall(require, 'template-string')

if not present then
  return
end

template_string.setup({
  filetypes = {
    'html',
    'typescript',
    'javascript',
    'typescriptreact',
    'javascriptreact',
    'python',
  }, -- filetypes where the plugin is active
  jsx_brackets = true, -- must add brackets to jsx attributes
  remove_template_string = true, -- remove backticks when there are no template string
  restore_quotes = {
    -- quotes used when "remove_template_string" option is enabled
    normal = [[']],
    jsx = [["]],
  },
})
