---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require('custom.highlights')

M.ui = {
  theme = 'catppuccin',
  theme_toggle = { 'catppuccin', 'onenord_light' },
  transparency = false,

  hl_override = highlights.override,
  hl_add = highlights.add,

  nvdash = {
    load_on_startup = false,
  },
}

M.plugins = 'custom.plugins'

-- check core.mappings for table structure
M.mappings = require('custom.mappings')

return M
