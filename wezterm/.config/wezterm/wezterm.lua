local wezterm = require('wezterm')

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = 'tokyonight_moon'

config.font_size = 18.0

config.max_fps = 240

config.font = wezterm.font('JetBrainsMono NFM', { weight = 'Medium' })

config.scrollback_lines = 200000

config.tab_max_width = 24

config.hide_tab_bar_if_only_one_tab = true

config.use_dead_keys = false

config.window_decorations = 'RESIZE' -- no title bar

config.native_macos_fullscreen_mode = true

config.window_close_confirmation = 'NeverPrompt'

config.keys = {
  -- Close current tab
  {
    key = 'w',
    mods = 'CMD',
    action = wezterm.action.CloseCurrentTab({ confirm = false }),
  },

  -- New tab
  {
    key = 't',
    mods = 'SUPER',
    action = wezterm.action.SpawnCommandInNewTab({
      domain = 'CurrentPaneDomain',
    }),
  },

  -- Toggle fullscreen
  {
    key = 'f',
    mods = 'CTRL|CMD',
    action = wezterm.action.ToggleFullScreen,
  },

  -- Open `t` - tmux smart session manager
  {
    key = 'j',
    mods = 'SHIFT|CMD',
    action = wezterm.action.SendString('\x00\x54'),
  },
}

return config
