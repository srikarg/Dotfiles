-- Miscellaneous
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set('n', ';', ':', { desc = 'Enter Command Mode', nowait = true })

vim.keymap.set('n', '<ESC>', '<CMD> :noh <CR>', { desc = 'Clear Highlights' })

vim.keymap.set('n', '<C-s>', '<CMD> w <CR>', { desc = 'Save Current Buffer' })

vim.keymap.set('n', '<C-c>', '<CMD> %y+ <CR>', { desc = 'Copy Entire Buffer' })

vim.keymap.set('n', '<leader>Q', '<cmd>qa<cr>', { desc = 'Quit all' })

-- Conversion via Pandoc
vim.keymap.set(
  'n',
  '<leader>cpj',
  '<CMD> %!pandoc -t jira % <CR>',
  { desc = '[C]onvert with [P]andoc to [J]ira Format' }
)

-- Moving Text

vim.keymap.set('n', '<A-k>', '<CMD> m .-2 <CR>==', { desc = 'Move Line Up' })

vim.keymap.set('n', '<A-j>', '<CMD> m .+1 <CR>==', { desc = 'Move Line Down' })

vim.keymap.set('v', '<A-k>', ":m'<-2<CR>gv=gv", { desc = 'Move Selection Up' })

vim.keymap.set(
  'v',
  '<A-j>',
  ":m'>+1<CR>gv=gv",
  { desc = 'Move Selection Down' }
)

vim.keymap.set('v', '<', '<gv', { desc = 'Indent Backward' })

vim.keymap.set('v', '>', '>gv', { desc = 'Indent Forward' })

-- Page Up/Down and Center
vim.keymap.set(
  'n',
  '<C-d>',
  '<C-d>zz',
  { desc = 'Page Down and Center', nowait = true }
)

vim.keymap.set(
  'n',
  '<C-u>',
  '<C-u>zz',
  { desc = 'Page Down and Center', nowait = true }
)

-- Splits
vim.keymap.set(
  'n',
  '<leader>V',
  '<CMD> vs <BAR> wincmd p <CR>',
  { desc = 'Vertical Split and Return to Previous Split', nowait = true }
)

vim.keymap.set(
  'n',
  '<leader>H',
  '<CMD> sp <BAR> wincmd p <CR>',
  { desc = 'Horizontal Split and Return to Previous Split', nowait = true }
)

-- Buffer Management
vim.keymap.set(
  'n',
  '<leader>b',
  '<CMD> enew <CR>',
  { desc = 'Edit New Buffer' }
)

vim.keymap.set(
  'n',
  '<leader>x',
  '<CMD> bdelete <CR>',
  { desc = 'Close Current Buffer', silent = true }
)

vim.keymap.set(
  'n',
  '<leader>X',
  '<CMD> %bdelete <CR>',
  { desc = 'Close All Buffers', silent = true }
)

-- Move Between Visual Lines with jk
vim.keymap.set(
  'n',
  'k',
  "v:count == 0 ? 'gk' : 'k'",
  { expr = true, silent = true }
)

vim.keymap.set(
  'n',
  'j',
  "v:count == 0 ? 'gj' : 'j'",
  { expr = true, silent = true }
)

-- Diagnostic keymaps
local diagnostics_active = true

vim.keymap.set(
  'n',
  '[d',
  vim.diagnostic.goto_prev,
  { desc = 'Go to previous diagnostic message' }
)

vim.keymap.set(
  'n',
  ']d',
  vim.diagnostic.goto_next,
  { desc = 'Go to next diagnostic message' }
)

vim.keymap.set(
  'n',
  '<leader>qf',
  vim.diagnostic.open_float,
  { desc = 'Open floating diagnostic message' }
)

vim.keymap.set('n', '<leader>qt', function()
  diagnostics_active = not diagnostics_active
  if diagnostics_active then
    vim.diagnostic.show()
  else
    vim.diagnostic.hide()
  end
end, { desc = '[T]oggle Diagnostic Visibility' })
