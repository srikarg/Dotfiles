local present, zenmode = pcall(require, 'zen-mode')

if not present then
  return
end

zenmode.setup({
  window = {
    backdrop = 0.9,
    width = 83, -- This leaves enough space for the line numbers column + 80 characters
    height = 1,
    options = {
      signcolumn = 'no',
      list = false,
    },
  },
  plugins = {
    options = {
      enabled = true,
      colorcolumn = false,
      ruler = false,
      showcmd = false,
    },
    gitsigns = { enabled = true },
    twilight = { enabled = true },
    tmux = { enabled = true },
    diagnostics = { enabled = true },
  },
})
