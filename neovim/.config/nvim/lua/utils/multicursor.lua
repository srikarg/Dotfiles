-- Shared helpers for Neovim 0.13 native multicursor.
-- A "multicursor" is an extmark in the `nvim.multicursor` namespace.
local M = {}

local multi_cursor_namespace = vim.api.nvim_create_namespace('nvim.multicursor')

--- Any multicursors in the current buffer?
---@return boolean
function M.has_multi_cursor_in_buffer()
  return #vim.api.nvim_buf_get_extmarks(0, multi_cursor_namespace, 0, -1, { limit = 1 }) > 0
end

--- A multicursor at exactly `position`? start == stop = a single point, 0-indexed.
---@param position [integer, integer]
---@return boolean
function M.has_multi_cursor_at_position(position)
  return #vim.api.nvim_buf_get_extmarks(0, multi_cursor_namespace, position, position, { limit = 1 }) > 0
end

--- Remove every multicursor in the current buffer.
---@return nil
function M.clear_multi_cursors_in_buffer()
  vim.api.nvim_buf_clear_namespace(0, multi_cursor_namespace, 0, -1)
end

return M
