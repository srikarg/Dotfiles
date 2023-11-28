--  This function gets run when an LSP connects to a particular buffer.
local default_on_attach = function(client, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  if client.server_capabilities.documentSymbolProvider then
    require('nvim-navbuddy').attach(client, bufnr)

    nmap('<leader>N', require('nvim-navbuddy').open, 'Open [N]avbuddy')
  end

  if client.server_capabilities.inlayHintProvider then
    local inlayHintsEnabled = false
    local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint

    nmap('<leader>ui', function()
      inlayHintsEnabled = not inlayHintsEnabled
      inlay_hint(bufnr, inlayHintsEnabled)
    end, 'Toggle [I]nlay Hints')
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap(
    'gd',
    require('telescope.builtin').lsp_definitions,
    '[G]oto [D]efinition'
  )
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap(
    'gi',
    require('telescope.builtin').lsp_implementations,
    '[G]oto [I]mplementation'
  )
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap(
    '<leader>ds',
    require('telescope.builtin').lsp_document_symbols,
    '[D]ocument [S]ymbols'
  )
  nmap(
    '<leader>ws',
    require('telescope.builtin').lsp_dynamic_workspace_symbols,
    '[W]orkspace [S]ymbols'
  )

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap(
    '<leader>wa',
    vim.lsp.buf.add_workspace_folder,
    '[W]orkspace [A]dd Folder'
  )
  nmap(
    '<leader>wr',
    vim.lsp.buf.remove_workspace_folder,
    '[W]orkspace [R]emove Folder'
  )
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')
end

return {
  -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',

  dependencies = {
    -- Automatically install Formatters, Linters, and LSPs to stdpath for neovim
    {
      'williamboman/mason.nvim',

      config = function()
        require('mason').setup()

        local ensure_installed = {
          -- Lua
          'stylua',

          -- Web Development
          'prettier',

          --Docker
          'hadolint',

          -- Markdown
          'markdownlint',

          -- Shell
          'shfmt',
          'shellcheck',
        }

        vim.api.nvim_create_user_command('MasonInstallAll', function()
          vim.cmd('MasonInstall ' .. table.concat(ensure_installed, ' '))
        end, {})
      end,
    },

    'hrsh7th/cmp-nvim-lsp',

    'hrsh7th/nvim-cmp',

    -- Additional lua configuration, makes nvim stuff amazing!
    {
      'folke/neodev.nvim',
    },

    {
      'williamboman/mason-lspconfig.nvim',
      config = function()
        -- Enable the following language servers
        --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
        --
        --  Add any additional override configuration in the following tables. They will be passed to
        --  the `settings` field of the server config. You must look up that documentation yourself.
        --
        --  If you want to override the default filetypes that your language server will attach to you can
        --  define the property 'filetypes' to the map in question.
        local servers = {
          html = {},

          cssls = {},

          tailwindcss = {},

          tsserver = {
            init_options = {
              preferences = {
                includeInlayParameterNameHints = 'all',
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
                importModuleSpecifierPreference = 'non-relative',
              },
            },
          },

          astro = {},

          svelte = {},

          jsonls = {
            settings = {
              json = {
                schemas = require('schemastore').json.schemas(),
                validate = {
                  enable = true,
                },
                format = {
                  enable = true,
                },
              },
            },
          },

          dockerls = {},

          docker_compose_language_service = {},

          emmet_language_server = {},

          bashls = {},

          marksman = {},

          lua_ls = {
            settings = {
              Lua = {
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
                hint = {
                  enable = true,
                  arrayIndex = 'Enable',
                  setType = true,
                },
              },
            },
          },

          yamlls = {
            filetypes = {
              'yaml',
              'yaml.docker-compose',
              'helm',
            },

            settings = {
              yaml = {
                format = {
                  enable = true,
                  singleQuote = true,
                  bracketSpacing = true,
                },
                validate = true,
                completion = true,
                schemaStore = { enable = false, url = '' },
                editor = { formatOnType = true },
                schemas = require('schemastore').yaml.schemas(),
              },
              redhat = {
                telemetry = {
                  enabled = false,
                },
              },
            },

            on_attach = function(_, bufnr)
              if
                vim.bo[bufnr].buftype ~= ''
                or vim.bo[bufnr].filetype == 'helm'
              then
                vim.diagnostic.disable()
              end
            end,
          },

          eslint = {
            on_attach = function(_, bufnr)
              vim.api.nvim_create_autocmd('BufWritePre', {
                buffer = bufnr,
                command = 'EslintFixAll',
              })
            end,
          },
        }

        -- Ensure the servers above are installed
        local mason_lspconfig = require('mason-lspconfig')

        mason_lspconfig.setup({
          ensure_installed = vim.tbl_keys(servers),
        })

        -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities =
          require('cmp_nvim_lsp').default_capabilities(capabilities)
        -- Add folding capabilities for nvim-ufo
        capabilities.textDocument.foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true,
        }
        -- Enable snippet capabilities
        capabilities.textDocument.completion.completionItem.snippetSupport =
          true

        mason_lspconfig.setup_handlers({
          function(server_name)
            require('lspconfig')[server_name].setup({
              capabilities = capabilities,
              on_attach = function(client, bufnr)
                if servers[server_name].on_attach then
                  servers[server_name].on_attach(client, bufnr)
                end

                default_on_attach(client, bufnr)
              end,
              settings = (servers[server_name] or {}).settings,
              init_options = (servers[server_name] or {}).init_options,
              filetypes = (servers[server_name] or {}).filetypes,
            })
          end,
        })
      end,
    },

    -- Navigation tool to navigate LSP nodes
    {
      'SmiteshP/nvim-navbuddy',

      dependencies = {
        {
          'SmiteshP/nvim-navic',

          config = function()
            require('nvim-navic').setup({
              icons = require('config').icons.kinds,
            })
          end,
        },

        'MunifTanjim/nui.nvim',
      },

      config = function()
        local actions = require('nvim-navbuddy.actions')
        require('nvim-navbuddy').setup({
          window = {
            border = 'single', -- "rounded", "double", "solid", "none"
            -- or an array with eight chars building up the border in a clockwise fashion
            -- starting with the top-left corner. eg: { "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" }.
            size = { height = '40%', width = '100%' }, -- Or singular values, for example: size = "80%"
            position = { row = '100%', col = '0%' }, -- Or singular values, for example: position = "50%"
            scrolloff = nil, -- scrolloff value within navbuddy window
            sections = {
              left = {
                size = '20%',
                border = nil, -- You can set border style for each section individually as well.
              },
              mid = {
                size = '40%',
                border = nil,
              },
              right = {
                -- No size option for right most section. It fills to
                -- remaining area.
                border = nil,
                preview = 'leaf', -- Right section can show previews too.
                -- Options: "leaf", "always" or "never"
              },
            },
          },
          node_markers = {
            enabled = true,
            icons = {
              leaf = '  ',
              leaf_selected = ' → ',
              branch = ' ',
            },
          },
          icons = require('config').icons.kinds,
          use_default_mappings = true, -- If set to false, only mappings set
          -- by user are set. Else default
          -- mappings are used for keys
          -- that are not set by user
          mappings = {
            ['<esc>'] = actions.close(), -- Close and cursor to original location
            ['q'] = actions.close(),

            ['j'] = actions.next_sibling(), -- down
            ['k'] = actions.previous_sibling(), -- up

            ['h'] = actions.parent(), -- Move to left panel
            ['l'] = actions.children(), -- Move to right panel
            ['0'] = actions.root(), -- Move to first panel

            ['v'] = actions.visual_name(), -- Visual selection of name
            ['V'] = actions.visual_scope(), -- Visual selection of scope

            ['y'] = actions.yank_name(), -- Yank the name to system clipboard "+
            ['Y'] = actions.yank_scope(), -- Yank the scope to system clipboard "+

            ['i'] = actions.insert_name(), -- Insert at start of name
            ['I'] = actions.insert_scope(), -- Insert at start of scope

            ['a'] = actions.append_name(), -- Insert at end of name
            ['A'] = actions.append_scope(), -- Insert at end of scope

            ['r'] = actions.rename(), -- Rename currently focused symbol

            ['d'] = actions.delete(), -- Delete scope

            ['f'] = actions.fold_create(), -- Create fold of current scope
            ['F'] = actions.fold_delete(), -- Delete fold of current scope

            ['c'] = actions.comment(), -- Comment out current scope

            ['<enter>'] = actions.select(), -- Goto selected symbol
            ['o'] = actions.select(),

            ['J'] = actions.move_down(), -- Move focused node down
            ['K'] = actions.move_up(), -- Move focused node up

            ['s'] = actions.toggle_preview(), -- Show preview of current node

            ['<C-v>'] = actions.vsplit(), -- Open selected node in a vertical split
            ['<C-s>'] = actions.hsplit(), -- Open selected node in a horizontal split

            ['t'] = actions.telescope({ -- Fuzzy finder at current level.
              layout_config = { -- All options that can be
                height = 0.60, -- passed to telescope.nvim's
                width = 0.60, -- default can be passed here.
                prompt_position = 'top',
                preview_width = 0.50,
              },
              layout_strategy = 'horizontal',
            }),

            ['g?'] = actions.help(), -- Open mappings help window
          },
          lsp = {
            auto_attach = false, -- If set to true, you don't need to manually use attach function
            preference = nil, -- list of lsp server names in order of preference
          },
          source_buffer = {
            follow_node = true, -- Keep the current node in focus on the source buffer
            highlight = true, -- Highlight the currently focused node
            reorient = 'smart', -- "smart", "top", "mid" or "none"
            scrolloff = nil, -- scrolloff value when navbuddy is open
          },
        })
      end,
    },
  },

  config = function()
    for name, icon in pairs(require('config').icons.diagnostics) do
      name = 'DiagnosticSign' .. name
      vim.fn.sign_define(name, { text = icon, texthl = name, numhl = '' })
    end

    vim.diagnostic.config({
      underline = true,
      update_in_insert = false,
      virtual_text = {
        spacing = 4,
        source = 'if_many',
        prefix = function(diagnostic)
          local icons = require('config').icons.diagnostics
          for d, icon in pairs(icons) do
            if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
              return icon
            end
          end
        end,
      },
      severity_sort = true,
    })
  end,
}
