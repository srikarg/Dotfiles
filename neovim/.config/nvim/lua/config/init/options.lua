-- [[ Setting options ]]
-- See `:help vim.o`

-- Disable nvim intro and other messages
vim.opt.shortmess:append({ W = true, I = true, c = true, C = true, s = true })

-- Vertically split windows on the right side by default
vim.opt.splitright = true

-- Horizontally split windows below by default
vim.opt.splitbelow = true

vim.opt.confirm = true

vim.opt.formatoptions = 'jcroqlnt'
vim.opt.grepformat = '%f:%l:%c:%m'
vim.opt.grepprg = 'rg --vimgrep'

-- Indenting
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

-- Set highlight on search
vim.opt.hlsearch = true

-- Make line numbers default
vim.opt.number = true

-- Enable cursor line
vim.opt.cursorline = true

-- Numbers
vim.opt.number = true
vim.opt.numberwidth = 2
vim.opt.ruler = false

-- Go to previous/next line with h, l, left arrow, and right arrow
-- when cursor reaches end/beginning of line
vim.opt.whichwrap:append('<>[]hl')

-- Relative line numbers
vim.opt.relativenumber = true

-- Enable mouse mode
vim.opt.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.opt.undofile = true
vim.opt.undolevels = 10000

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Enable color column
vim.opt.colorcolumn = '80'

-- Use default text width of 80 characters
vim.opt.textwidth = 80

-- Display space and end of line characters
vim.opt.list = true
vim.opt.listchars:append('space:⋅')
vim.opt.listchars:append('eol:↵')

vim.opt.spelllang = 'en_us'

vim.opt.sessionoptions = {
  'buffers',
  'curdir',
  'folds',
  'help',
  'tabpages',
  'winsize',
  'winpos',
  'terminal',
  'localoptions',
}
