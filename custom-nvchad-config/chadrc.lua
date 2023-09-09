---@type ChadrcConfig
local M = {}

local core = require('custom.utils.core')
local highlights = require('custom.highlights')

M.ui = {
  extended_integrations = { 'navic', 'dap', 'trouble', 'codeactionmenu' },
  theme = 'catppuccin',
  theme_toggle = { 'catppuccin', 'onenord_light' },
  transparency = false,
  lsp_semantic_tokens = true,

  hl_override = highlights.override,
  hl_add = highlights.add,

  statusline = core.statusline,

  nvdash = {
    load_on_startup = false,
  },
}

M.plugins = 'custom.plugins'

-- check core.mappings for table structure
M.mappings = require('custom.mappings')

return M
