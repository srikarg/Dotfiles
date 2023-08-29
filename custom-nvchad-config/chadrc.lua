---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require('custom.highlights')

-- Partially sourced from https://github.com/NvChad/ui/blob/v2.0/lua/nvchad/statusline/default.lua#L71-L87
local getFileInfo = function()
  local fn = vim.fn

  local icon = ' 󰈚 '

  local currentFilePath = fn.expand('%')
  local currentFilePathTail = fn.expand('%:t')
  local currentFilePathIsEmpty = currentFilePath == '' or currentFilePath == '.'

  local filename = (currentFilePathIsEmpty and 'Empty ') or currentFilePathTail

  -- Run ':help filename-modifiers' for an understanding of what the ':~:.' is doing
  local filepath = (filename == 'Empty ' and filename)
    or (' ' .. fn.fnamemodify(fn.bufname(fn.bufnr()), ':~:.'))

  if filename ~= 'Empty ' then
    local devicons_present, devicons = pcall(require, 'nvim-web-devicons')

    if devicons_present then
      local ft_icon = devicons.get_icon(filename)
      icon = (ft_icon ~= nil and ' ' .. ft_icon) or ''
    end
  end

  return '%#St_file_info#' .. icon .. filepath .. '%#St_file_sep#' .. ' '
end

local function navic_statusline()
  local navic = require('nvim-navic')

  if navic.is_available() then
    return navic.get_location()
  else
    return ' '
  end
end

M.ui = {
  extended_integrations = { 'navic' },
  theme = 'catppuccin',
  theme_toggle = { 'catppuccin', 'onenord_light' },
  transparency = false,
  lsp_semantic_tokens = true,

  hl_override = highlights.override,
  hl_add = highlights.add,

  statusline = {
    theme = 'default',
    -- The modules argument here is the default table of modules here: https://github.com/NvChad/ui/blob/v2.0/lua/nvchad/statusline/default.lua
    overriden_modules = function(modules)
      modules[2] = getFileInfo()
      -- table.insert(modules, 6, navic_statusline())
    end,
  },

  nvdash = {
    load_on_startup = false,
  },
}

M.plugins = 'custom.plugins'

-- check core.mappings for table structure
M.mappings = require('custom.mappings')

return M
