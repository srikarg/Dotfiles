-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local M = {}

-- See https://github.com/NvChad/base46/blob/v2.0/lua/base46/themes/catppuccin.lua for the theme colors of catppuccin

-- After changing the highlight groups, save this file, quit and re-open NeoVim, and run `:lua require"base46".load_all_highlights()` to apply the changes and refresh the base64 plugin's cache

---@type Base46HLGroupsList
M.override = {
  -- General
  Cursor = { bg = 'white' },
  CursorLine = { bg = 'lightbg' },
  Comment = { italic = true },

  -- NvimTree
  NvimTreeGitNew = { fg = 'green' },
  NvimTreeGitDirty = { fg = 'yellow' },
  NvimTreeGitDeleted = { fg = 'red' },
  NvimTreeCursorLine = { bg = 'one_bg3' },

  -- indent-blankline
  IndentBlanklineChar = { fg = 'grey', bold = true },
  IndentBlanklineSpaceChar = { fg = 'grey', bold = true },
  IndentBlanklineContextChar = { fg = 'grey', bold = true },
  IndentBlanklineContextStart = { bg = 'one_bg2' },

  NavicText = { fg = 'white' },

  -- Diff
  DiffChange = { fg = 'black', bg = 'yellow' },
  DiffAdd = { fg = 'black', bg = 'vibrant_green' },
  DiffDelete = { fg = 'black', bg = 'red' },
  DiffText = { fg = 'black', bg = 'yellow', bold = true },

  DiffviewDim1 = { fg = 'grey' },
  DiffviewReference = { fg = 'cyan' },
  DiffviewPrimary = { fg = 'cyan' },
  DiffviewSecondary = { fg = 'blue' },
  DiffviewNonText = { link = 'DiffviewDim1' },
  DiffviewStatusUnmerged = { link = 'GitMerge' },
  DiffviewStatusUntracked = { link = 'GitNew' },
  DiffviewStatusModified = { link = 'GitDirty' },
  DiffviewStatusRenamed = { link = 'GitRenamed' },
  DiffviewStatusDeleted = { link = 'GitDeleted' },
  DiffviewStatusAdded = { link = 'GitStaged' },
  DiffviewFilePanelRootPath = { link = 'NvimTreeRootFolder' },
  DiffviewFilePanelTitle = { link = 'Title' },
  DiffviewFilePanelCounter = { fg = 'cyan' },
  DiffviewFilePanelInsertions = { link = 'GitNew' },
  DiffviewFilePanelDeletions = { link = 'GitDeleted' },
  DiffviewFilePanelConflicts = { link = 'GitMerge' },
  DiffviewFolderSign = { link = 'NvimTreeFolderIcon' },
  DiffviewDiffDelete = { link = 'Comment' },
}

---@type HLTable
M.add = {
  -- NvimTree
  NvimTreeGitStaged = { fg = 'orange' },

  -- Git Signs
  GitSignsCurrentLineBlame = { fg = 'light_grey', bold = true },

  GitSignsChange = { fg = 'green' },
  GitSignsAdd = { fg = 'vibrant_green' },
  GitSignsDelete = { fg = 'red' },
  GitSignsText = { fg = 'white', bg = 'red', bold = true },

  -- Deprecated
  cssDeprecated = { strikethrough = true },
  javaScriptDeprecated = { strikethrough = true },

  HarpoonHl = { fg = 'cyan', bg = 'statusline_bg' },

  -- vim-illuminate
  IlluminatedWordText = {
    bg = 'light_grey',
    -- fg = 'white',
    underline = false,
  },
  IlluminatedWordRead = {
    bg = 'light_grey',
    -- fg = 'white',
    underline = false,
  },
  IlluminatedWordWrite = {
    bg = 'light_grey',
    -- fg = 'white',
    underline = false,
  },
}

return M
