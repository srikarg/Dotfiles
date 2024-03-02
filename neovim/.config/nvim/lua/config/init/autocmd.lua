local autocmd = vim.api.nvim_create_autocmd

local highlight_group =
  vim.api.nvim_create_augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
  group = highlight_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Don't list quickfix buffers
autocmd('FileType', {
  pattern = 'qf',
  callback = function()
    vim.opt_local.buflisted = false
  end,
})

-- Go to last known position when opening file and center the line on the screen
autocmd('BufWinEnter', {
  pattern = { '*' },
  callback = function()
    vim.api.nvim_exec('silent! normal! g`"zz', false)
  end,
})
