local autocmd = vim.api.nvim_create_autocmd

vim.opt.relativenumber = true
vim.opt.colorcolumn = '80'

-- Display space and end of line characters
vim.opt.list = true
vim.opt.listchars:append('space:⋅')
vim.opt.listchars:append('eol:↵')

-- Auto resize panes when resizing nvim window
autocmd('VimResized', {
  pattern = '*',
  command = 'tabdo wincmd =',
})

-- Include line numbers in Telescope previewer and avoid line wrapping if previewing a CSV file
autocmd('User', {
  pattern = 'TelescopePreviewerLoaded',
  callback = function(args)
    if args.data.filetype ~= 'help' then
      vim.wo.number = true
    elseif args.data.bufname:match('*.csv') then
      vim.wo.wrap = false
    end
  end,
})
