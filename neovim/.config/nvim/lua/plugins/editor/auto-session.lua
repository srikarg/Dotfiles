return {
  'rmagatti/auto-session',

  event = 'VimEnter',

  opts = function()
    local function close_all_floating_wins()
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local config = vim.api.nvim_win_get_config(win)
        if config.relative ~= '' then
          vim.api.nvim_win_close(win, false)
        end
      end
    end

    return {
      auto_restore_enabled = true,
      auto_save_enabled = true,
      auto_session_create_enabled = true,
      auto_session_enable_last_session = vim.loop.cwd()
        == vim.loop.os_homedir(),
      auto_session_enabled = true,
      auto_session_suppress_dirs = { '~/Downloads', '/' },
      auto_session_use_git_branch = true,
      log_level = 'info',
      pre_save_cmds = { close_all_floating_wins, 'cclose' },
    }
  end,
}
