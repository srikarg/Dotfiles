return {
  'folke/trouble.nvim',

  dependencies = { 'nvim-tree/nvim-web-devicons' },

  cmd = { 'Trouble', 'TroubleToggle' },

  keys = {
    {
      '<leader>xs',
      '<CMD> Trouble lsp toggle focus=false win.position=right win.size=0.5 <CR>',
      desc = 'LSP Information (Trouble)',
    },
  },

  opts = {
    use_diagnostic_signs = true,

    icons = {
      indent = {
        middle = ' ',
        last = ' ',
        top = ' ',
        ws = '│  ',
      },
    },

    modes = {
      diagnostics = {
        groups = {
          { 'filename', format = '{file_icon} {basename:Title} {count}' },
        },
      },
    },
  },
}
