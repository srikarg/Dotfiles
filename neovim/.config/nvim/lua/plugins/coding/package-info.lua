return {
  {
    'vuki656/package-info.nvim',

    event = 'BufEnter package.json',

    keys = {
      {
        '<leader>ni',
        "<CMD> lua require('package-info').install() <CR>",
        desc = ' Install package',
      },

      {
        '<leader>nc',
        "<CMD> lua require('package-info').change_version() <CR>",
        desc = ' Change package version',
      },
    },

    opts = {
      highlights = {
        -- Text color for up to date package virtual text
        up_to_date = {
          fg = '#3C4048',
        },
        -- Text color for outdated package virtual text
        outdated = {
          fg = '#fc514e',
        },
      },
      icons = {
        enable = true, -- Whether to display icons
      },

      autostart = true, -- Whether to autostart when `package.json` is opened
      hide_up_to_date = true, -- It hides up to date versions when displaying virtual text
      hide_unstable_versions = true, -- It hides unstable versions from version list e.g next-11.1.3-canary3
    },

    -- https://github.com/vuki656/package-info.nvim/issues/155#issuecomment-2270572104
    config = function(_, opts)
      require('package-info').setup(opts)

      vim.cmd([[highlight PackageInfoUpToDateVersion guifg=]] .. opts.colors.up_to_date)
      vim.cmd([[highlight PackageInfoOutdatedVersion guifg=]] .. opts.colors.outdated)
    end,
  },

  {
    'folke/which-key.nvim',
    opts = {
      spec = {
        {
          mode = { 'n', 'v' },
          { '<leader>n', group = 'npm' },
        },
      },
    },
  },
}
