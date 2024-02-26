-- [[ Setting options ]]
-- See `:help vim.o`

-- Disable nvim intro and other messages
vim.opt.shortmess:append({ W = true, I = true, c = true, C = true, s = true })

-- Vertically split windows on the right side by default
vim.opt.splitright = true

-- Horizontally split windows below by default
vim.opt.splitbelow = true

-- Confirm before exiting an edited buffer
vim.opt.confirm = true

-- Register mouse move events
vim.opt.mousemoveevent = true

-- Format options
vim.opt.formatoptions = 'jcroqlnt'

-- Grep options
vim.opt.grepformat = '%f:%l:%c:%m'
vim.opt.grepprg = 'rg --vimgrep'

-- Always show the status line only for the last window
vim.opt.laststatus = 3

-- Hide mode since we have statusline
vim.opt.showmode = false

-- Indenting
vim.opt.expandtab = true
vim.opt.shiftround = true
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
vim.opt.relativenumber = true
vim.opt.numberwidth = 2
vim.opt.ruler = false

-- Go to previous/next line with h, l, left arrow, and right arrow
-- when cursor reaches end/beginning of line
vim.opt.whichwrap:append('<>[]hl')

-- Enable mouse mode
vim.opt.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true
vim.opt.undolevels = 10000

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.opt.completeopt = 'menu,menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.opt.termguicolors = true

-- Enable color column
vim.opt.colorcolumn = '80'

-- Use default text width of 80 characters
vim.opt.textwidth = 80

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Display space and end of line characters
vim.opt.list = true
vim.opt.listchars =
  { tab = '» ', trail = '·', nbsp = '␣', space = '⋅', eol = '↵' }

-- Spell Check Settings
vim.opt.spelllang = 'en_us'
vim.opt.spelloptions = 'camel'

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

-- Folding
vim.opt.foldcolumn = '1'
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldnestmax = 10
vim.opt.foldenable = true
vim.opt.fillchars = {
  foldopen = '',
  foldclose = '',
  fold = ' ',
  foldsep = ' ',
  diff = '╱',
  eob = ' ',
}
