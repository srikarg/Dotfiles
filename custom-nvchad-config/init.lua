vim.opt.relativenumber = true
vim.opt.colorcolumn = '80'

-- Display space and end of line characters
vim.opt.list = true
vim.opt.listchars:append('space:⋅')
vim.opt.listchars:append('eol:↵')

vim.opt.spelllang = 'en_us'

require('custom.utils.autocmd')
require('custom.utils.usercmd')
