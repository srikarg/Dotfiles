local M = {}

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

local function dap_statusline()
  local ok, dap = pcall(require, 'dap')
  if ok then
    local status = dap.status()
    if status ~= '' then
      return '   ' .. status .. ' '
    end
    return ''
  else
    return ''
  end
end

local function harpoon_statusline()
  local harpoonMarked = require('harpoon.mark')
  local filename = vim.api.nvim_buf_get_name(0)
  local success, index = pcall(harpoonMarked.get_index_of, filename)

  if success and index and index ~= nil then
    return '%#HarpoonHl#' .. ' 󱡀 ' .. index .. ' '
  else
    return ''
  end
end

M.statusline = {
  theme = 'default',
  -- The modules argument here is the default table of modules here: https://github.com/NvChad/ui/blob/v2.0/lua/nvchad/statusline/default.lua
  overriden_modules = function(modules)
    modules[2] = getFileInfo()

    table.insert(modules, 4, harpoon_statusline())

    table.insert(modules, 8, dap_statusline())

    -- table.insert(modules, 5, navic_statusline())
  end,
}

return M
