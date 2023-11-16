return {
  'folke/trouble.nvim',

  dependencies = { 'nvim-tree/nvim-web-devicons' },

  cmd = { 'Trouble', 'TroubleToggle' },

  keys = {
    {
      '<leader>xx',
      '<CMD> TroubleToggle <CR>',
      desc = 'Toggle Trouble',
    },
    {
      '<leader>xd',
      '<CMD> TroubleToggle document_diagnostics <CR>',
      desc = 'Document Diagnostics (Trouble)',
    },
    {
      '<leader>xw',
      '<CMD> TroubleToggle workspace_diagnostics <CR>',
      desc = 'Workspace Diagnostics (Trouble)',
    },
    {
      '<leader>xL',
      '<CMD> TroubleToggle loclist <CR>',
      desc = 'Location List (Trouble)',
    },
    {
      '<leader>xQ',
      '<CMD> TroubleToggle quickfix <CR>',
      desc = 'Quickfix List (Trouble)',
    },
    {
      '[q',
      function()
        if require('trouble').is_open() then
          require('trouble').previous({ skip_groups = true, jump = true })
        else
          local ok, err = pcall(vim.cmd.cprev)
          if not ok then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      end,
      desc = 'Previous Trouble/Quickfix List Item',
    },
    {
      ']q',
      function()
        if require('trouble').is_open() then
          require('trouble').next({ skip_groups = true, jump = true })
        else
          local ok, err = pcall(vim.cmd.cnext)
          if not ok then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      end,
      desc = 'Next Trouble/Quickfix List Item',
    },
  },

  opts = {
    use_diagnostic_signs = true,
  },
}
