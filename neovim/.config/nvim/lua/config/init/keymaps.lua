-- Miscellaneous
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set('n', ';', ':', { desc = 'Enter Command Mode', nowait = true })

vim.keymap.set('n', '<ESC>', '<CMD> :noh <CR>', { desc = 'Clear Highlights' })

vim.keymap.set('n', '<C-s>', '<CMD> w <CR>', { desc = 'Save Current Buffer' })

vim.keymap.set('n', '<C-c>', '<CMD> %y+ <CR>', { desc = 'Copy Entire Buffer' })

-- Spell Check
vim.keymap.set(
  'n',
  '<leader>us',
  '<CMD>set spell! <CR>',
  { desc = 'Toggle [S]pell Check' }
)

-- Conversion via Pandoc
vim.keymap.set('n', '<leader>cp', function()
  -- https://pandoc.org/MANUAL.html#general-options
  local from_format = vim.fn.input('From format (e.g. markdown): ')

  -- Check if the user pressed <Esc> to cancel input
  if from_format == '' or from_format == '\27' then
    return
  end

  local to_format = vim.fn.input('To format (e.g. jira): ')

  -- Check if the user pressed <Esc> to cancel input
  if to_format == '' or to_format == '\27' then
    return
  end

  local command = ''

  if from_format ~= '' and to_format ~= '' then
    command = 'pandoc -f ' .. from_format .. ' -t ' .. to_format .. ' -'
  elseif to_format ~= '' then
    command = 'pandoc -t ' .. to_format .. ' -'
  else
    vim.api.nvim_err_writeln(
      'Invalid input. You must specify the to format at the very least.'
    )
  end
  if command ~= '' then
    vim.cmd('%!' .. command)
  end
end, { desc = '[C]onvert with [P]andoc' })

vim.keymap.set(
  'n',
  '<leader>cpj',
  '<CMD> %!pandoc -t jira - <CR>',
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
  '<leader>n',
  '<CMD> enew <CR>',
  { desc = 'Edit [N]ew Buffer' }
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
  '<leader>cf',
  vim.diagnostic.open_float,
  { desc = 'Open [C]ode [F]loating Diagnostic Message' }
)

vim.keymap.set('n', '<leader>ut', function()
  diagnostics_active = not diagnostics_active
  if diagnostics_active then
    vim.diagnostic.show()
  else
    vim.diagnostic.hide()
  end
end, { desc = '[T]oggle Diagnostic Visibility' })

-- Lists keymaps
vim.keymap.set(
  'n',
  '<leader>xl',
  '<CMD> lopen <CR>',
  { desc = 'Open Location List' }
)
vim.keymap.set(
  'n',
  '<leader>xq',
  '<CMD> copen <CR>',
  { desc = 'Open Quickfix List' }
)

vim.api.nvim_create_user_command(
  'Cnext',
  'try | cnext | catch | cfirst | catch | endtry',
  {}
)
vim.api.nvim_create_user_command(
  'Cprev',
  'try | cprev | catch | clast | catch | endtry',
  {}
)
vim.keymap.set(
  'n',
  '[q',
  '<CMD> Cprev <CR>',
  { desc = 'Previous Quickfix List Item' }
)
vim.keymap.set(
  'n',
  ']q',
  '<CMD> Cnext <CR>',
  { desc = 'Next Quickfix List Item' }
)
