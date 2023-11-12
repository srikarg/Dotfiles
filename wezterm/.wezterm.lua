local wezterm = require('wezterm')

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = 'tokyonight_night'

config.font_size = 16.0

config.font = wezterm.font('JetBrainsMono Nerd Font', { weight = 'Light' })

config.scrollback_lines = 200000

config.tab_max_width = 24

config.hide_tab_bar_if_only_one_tab = true

config.use_dead_keys = false

config.window_decorations = 'RESIZE' -- no title bar
config.window_background_opacity = 0.95

config.native_macos_fullscreen_mode = true

config.keys = {
  {
    key = 't',
    mods = 'SUPER',
    action = wezterm.action.SpawnCommandInNewTab({
      domain = 'CurrentPaneDomain',
    }),
  },

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
