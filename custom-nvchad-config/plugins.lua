local overrides = require('custom.configs.overrides')

---@type NvPluginSpec[]
local plugins = {
  {
    'christoomey/vim-tmux-navigator',
    lazy = false,
  },

  {
    'tpope/vim-obsession',
    lazy = false,
  },

  {
    'nacro90/numb.nvim',
    lazy = false,
    config = true,
  },

  {
    'ggandor/leap.nvim',
    lazy = false,
    dependencies = { 'tpope/vim-repeat' },
    config = function()
      require('custom.configs.plugins.leap')
    end,
  },

  {
    'ThePrimeagen/harpoon',
    lazy = false,
  },

  {
    'rmagatti/gx-extended.nvim',
    keys = { 'gx' },
    config = function()
      require('custom.configs.plugins.gx-extended')
    end,
  },

  {
    'mfussenegger/nvim-dap',
    config = function()
      require('custom.configs.plugins.dap.adapters.javascript')
      require('core.utils').load_mappings('dap')
    end,
  },

  {
    'theHamsta/nvim-dap-virtual-text',
    dependencies = { 'mfussenegger/nvim-dap' },
    config = true,
  },

  {
    'rcarriga/nvim-dap-ui',
    event = 'VeryLazy',
    dependencies = {
      'mfussenegger/nvim-dap',
      'theHamsta/nvim-dap-virtual-text',
    },
    config = function()
      require('custom.configs.plugins.dap.ui')
    end,
  },

  {
    'nvim-telescope/telescope-dap.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-treesitter/nvim-treesitter',
      'mfussenegger/nvim-dap',
    },
    config = true,
  },

  {
    'amrbashir/nvim-docs-view',
    opt = true,
    cmd = { 'DocsViewToggle' },
    config = function()
      require('custom.configs.plugins.docs-view')
    end,
  },

  {
    'axelvc/template-string.nvim',
    ft = {
      'astro',
      'html',
      'javascript',
      'javascriptreact',
      'python',
      'svelte',
      'typescript',
      'typescriptreact',
    },
    config = function()
      require('custom.configs.plugins.template-string')
    end,
  },

  {
    'mbbill/undotree',
    lazy = false,
    config = function()
      require('custom.configs.plugins.undotree')
    end,
  },

  {
    'folke/zen-mode.nvim',
    dependencies = { 'folke/twilight.nvim' },
    cmd = 'ZenMode',
    config = function()
      require('custom.configs.plugins.zenmode')
      require('custom.configs.plugins.twilight')
    end,
  },

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
    'ruifm/gitlinker.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = 'VeryLazy',
    config = function()
      require('custom.configs.plugins.gitlinker')
    end,
  },

  {
    'RRethy/vim-illuminate',
    event = 'VeryLazy',
    config = function()
      require('custom.configs.plugins.illuminate')
    end,
  },

  {
    'kylechui/nvim-surround',
    branch = 'main', -- Use `*` `version` for stability; use `main` `branch` for the latest features
    event = 'VeryLazy',
    config = true,
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
      {
        'SmiteshP/nvim-navbuddy',
        dependencies = {
          'SmiteshP/nvim-navic',
          'MunifTanjim/nui.nvim',
        },
        config = function()
          require('custom.configs.plugins.navbuddy')
        end,
      },
      {
        'SmiteshP/nvim-navic',
        config = function()
          require('custom.configs.plugins.navic')
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
    'nvim-tree/nvim-web-devicons',
    opts = overrides.devicons,
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
    dependencies = {
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
      },
      {
        'nvim-telescope/telescope-live-grep-args.nvim',
      },
    },
    opts = overrides.telescope,
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    opts = overrides.blankline,
  },

  {
    'NvChad/nvim-colorizer.lua',
    opts = overrides.colorizer,
  },

  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Cmp Sources Plugins
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-calc',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'js-everts/cmp-tailwind-colors',
    },
    config = function()
      local nvChadDefaultConfig = require('plugins.configs.cmp')
      local customConfig = overrides.cmp
      local mergedConfig =
        vim.tbl_deep_extend('force', nvChadDefaultConfig, customConfig)

      dofile(vim.g.base46_cache .. 'cmp')

      local defaultFormatFunction = nvChadDefaultConfig.formatting.format

      mergedConfig.formatting.format = function(entry, item)
        if item.kind == 'Color' then
          item = require('cmp-tailwind-colors').format(entry, item)
          if item.kind == 'Color' then
            return defaultFormatFunction(entry, item)
          end
          return item
        end
        return defaultFormatFunction(entry, item)
      end

      require('cmp').setup(mergedConfig)
    end,
  },
}

return plugins
