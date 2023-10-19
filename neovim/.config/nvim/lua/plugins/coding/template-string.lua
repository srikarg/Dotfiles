return {
  'axelvc/template-string.nvim',

  ft = {
    'astro',
    'html',
    'javascript',
    'javascriptreact',
    'python',
    'svelte',
    'typescript',
    'typescriptreact',
  },

  opts = {
    -- filetypes where the plugin is active
    filetypes = {
      'astro',
      'html',
      'javascript',
      'javascriptreact',
      'python',
      'svelte',
      'typescript',
      'typescriptreact',
    },
    -- must add brackets to jsx attributes
    jsx_brackets = true,
    -- remove backticks when there are no template string
    remove_template_string = true,
    restore_quotes = {
      -- quotes used when "remove_template_string" option is enabled
      normal = [[']],
      jsx = [["]],
    },
  },
}
