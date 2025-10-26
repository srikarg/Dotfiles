-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- When diagnostic lines are on, turn virtual text off and vice-versa.
vim.keymap.set('', '<leader>bl', function()
  vim.diagnostic.config({
    virtual_lines = not vim.diagnostic.config().virtual_lines,
    virtual_text = not vim.diagnostic.config().virtual_text,
  })
end, { desc = 'Toggle Diagnostic [l]ines' })

vim.keymap.set('', '<leader>gp', function()
  vim.cmd('r !git log --pretty=format:"- \\%B" develop..HEAD')
end, { desc = '  Paste Git Commit Messages Since Develop' })

vim.keymap.set('', '<leader>qr', function()
  vim.cmd('restart lua require("persistence").load()')
end, { desc = 'Restart Neovim' })
