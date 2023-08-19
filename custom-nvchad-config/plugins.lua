local overrides = require('custom.configs.overrides')

---@type NvPluginSpec[]
local plugins = {
  {
    'max397574/better-escape.nvim',
    event = 'InsertEnter',
    config = true,
  },

  {
    'b0o/schemastore.nvim',
    ft = { 'json', 'jsonc' },
  },

  {
    'ggandor/leap.nvim',
    event = { 'VeryLazy' },
    dependencies = { 'tpope/vim-repeat' },
    config = function()
      require('custom.configs.plugins.leap')
    end,
  },

  {
    'danymat/neogen',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = true,
  },

  {
    'nvim-treesitter/nvim-treesitter-context',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      enable = true,
      max_lines = 0,
      line_numbers = true,
    },
  },

  {
    'RRethy/nvim-treesitter-textsubjects',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      require('nvim-treesitter.configs').setup(
        overrides.treesitter.textsubjects
      )
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('nvim-treesitter.configs').setup(overrides.treesitter.textobjects)
    end,
  },

  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = { 'Trouble', 'TroubleToggle' },
    config = true,
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Format and Linting
      {
        'jose-elias-alvarez/null-ls.nvim',
        config = function()
          require('custom.configs.plugins.null-ls')
        end,
      },
    },
    config = function()
      require('plugins.configs.lspconfig')
      require('custom.configs.plugins.lspconfig')
    end,
  },

  -- Overrides For Existing NVChad Plugins
  {
    'williamboman/mason.nvim',
    opts = overrides.mason,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    opts = overrides.treesitter,
  },

  {
    'nvim-tree/nvim-tree.lua',
    opts = overrides.nvimtree,
  },

  {
    'nvim-telescope/telescope.nvim',
    opts = overrides.telescope,
  },

  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Cmp Sources Plugins
      {
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
      },
    },
    opts = overrides.cmp,
  },
}

return plugins
